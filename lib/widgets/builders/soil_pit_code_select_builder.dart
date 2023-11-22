import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../dropdowns/drop_down_async_list.dart';

class SoilPitCodeSelectBuilder extends StatelessWidget {
  const SoilPitCodeSelectBuilder(
      {super.key,
      required this.code,
      required this.initPlotCodeName,
      required this.usedPlotCodes,
      required this.onChange});

  final String code;
  final String initPlotCodeName;
  final Future<List<String>> usedPlotCodes;
  final void Function(String) onChange;

  Future<List<String>> getPitCodeNames(String code, String initCode) async {
    Database db = Database.instance;
    String codeName = "";
    if (code.isEmpty) {
      codeName = "Please select soil pit code";
    } else {
      codeName = await db.referenceTablesDao.getSoilPitCodeCompiledName(code);
    }

    return [
      codeName,
      await db.referenceTablesDao.getSoilPitCodeCompiledName(initCode)
    ];
  }

  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;

    return FutureBuilder(
        future: getPitCodeNames(code, initPlotCodeName),
        builder: (BuildContext context, AsyncSnapshot<List<String>> text) {
          String name = text.data?[0] ?? "Error loading codename";
          String initName = text.data?[1] ?? "Error loading init codename";
          return FutureBuilder(
              future: usedPlotCodes,
              builder: (BuildContext context,
                  AsyncSnapshot<List<String>> usedCodes) {
                return DropDownAsyncList(
                  title: "Soil pit coder",
                  searchable: true,
                  onChangedFn: (s) {
                    onChange(s!);
                  },
                  disabledFn: (s) {
                    if (name != initName && s == initName) {
                      return false;
                    } else {
                      return usedCodes.data!.contains(s!);
                    }
                  },
                  asyncItems: (s) =>
                      db.referenceTablesDao.getSoilPitCodeCompiledNameList(),
                  selectedItem: name,
                );
              });
        });
  }
}

import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../dropdowns/drop_down_async_list.dart';

class SoilPitCodeSelectBuilder extends StatelessWidget {
  const SoilPitCodeSelectBuilder(
      {super.key,
      required this.code,
      required this.initPlotCodeName,
      required this.plotCodeNames,
      required this.usedPlotCodes,
      required this.onChange});

  final String code;
  final String initPlotCodeName;
  final Future<List<String>> plotCodeNames;
  final Future<List<String>> usedPlotCodes;
  final void Function(String) onChange;

  Future<List<String>> getPitCodeNames(String code, String initCode) async {
    Database db = Database.instance;
    String codeName = "";
    String initCodeName = "";

    if (code.isEmpty) {
      codeName = "Please select soil pit code";
    } else {
      codeName = await db.referenceTablesDao.getSoilPitCodeCode(code);
    }

    if (initCode.isEmpty) {
      initCodeName = "no initCode";
    } else {
      initCodeName = await db.referenceTablesDao.getSoilPitCodeName(code);
    }

    return [codeName, initCodeName];
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
                  asyncItems: (s) => plotCodeNames,
                  selectedItem: name,
                );
              });
        });
  }
}

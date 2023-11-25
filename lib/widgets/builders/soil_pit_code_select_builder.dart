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
  final void Function(String code) onChange;

  Future<String> getPitCodeName() async => code.isEmpty
      ? "Please select soil pit code"
      : await Database.instance.referenceTablesDao.getSoilPitCodeName(code);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPitCodeName(),
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          String name = text.data ?? "Error loading codename";
          return DropDownAsyncList(
            title: "Soil pit coder",
            searchable: true,
            onChangedFn: (s) {
              Database.instance.referenceTablesDao
                  .getSoilPitCodeCode(s!)
                  .then((code) => onChange(code));
            },
            asyncItems: (s) => plotCodeNames,
            selectedItem: name,
          );
          ;
        });
  }
}

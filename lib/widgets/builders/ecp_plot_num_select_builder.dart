import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../dropdowns/drop_down_default.dart';

class EcpPlotNumSelectBuilder extends StatelessWidget {
  const EcpPlotNumSelectBuilder(
      {super.key,
      required this.ecpSId,
      required this.plotType,
      this.startingPlotType = "",
      this.startingEcpNum = "",
      required this.selectedEcpNum,
      required this.updateEcpNum,
      this.enabled = true});

  final int ecpSId;
  final String startingPlotType;
  final String plotType;
  final String startingEcpNum;
  final String selectedEcpNum;
  final void Function(int ecpNum) updateEcpNum;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;

    return FutureBuilder(
        future: db.ecologicalPlotTablesDao.getUsedPlotNums(ecpSId, plotType),
        builder: (BuildContext context, AsyncSnapshot<List<int>> usedPlotNums) {
          return DropDownDefault(
            title: "Plot Number",
            enabled: enabled,
            searchable: true,
            onChangedFn: (s) => updateEcpNum(int.parse(s!)),
            disabledItemFn: (s) {
              if (startingPlotType == plotType &&
                  (selectedEcpNum != startingEcpNum && s == startingEcpNum)) {
                return false;
              } else {
                return usedPlotNums.data!
                    .contains(int.tryParse(s ?? "-1") ?? -1);
              }
            },
            itemsList: plotType.isEmpty
                ? []
                : const [
                    "1",
                    "2",
                    "3",
                    "4",
                    "5",
                    "6",
                    "7",
                    "8",
                    "9",
                    "10",
                    "11",
                    "12",
                    "13",
                    "14",
                    "15",
                    "16"
                  ],
            selectedItem: selectedEcpNum.isEmpty
                ? "Please select plot type"
                : selectedEcpNum,
          );
        });
  }
}

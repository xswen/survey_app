import 'package:flutter/material.dart';

import '../dropdowns/drop_down_default.dart';

class EcpSetPlotNum extends StatelessWidget {
  const EcpSetPlotNum({
    super.key,
    required this.getUsedPlotNums,
    required this.plotType,
    required this.startingPlotNum,
    required this.selectedItem,
    this.searchable = true,
    this.enabled = true,
    this.onBeforePopup,
    required this.updatePlotNum,
  });

  final Future<List<int?>> getUsedPlotNums;
  final String plotType;
  final String startingPlotNum;
  final String selectedItem;
  final bool searchable;
  final bool enabled;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(int) updatePlotNum;

  @override
  Widget build(BuildContext context) {
    List<String> itemList = const [
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
    ];

    String getSelectedItem() {
      if (plotType.isEmpty) {
        return "Please first select plot type";
      }

      return selectedItem.isNotEmpty
          ? selectedItem
          : "Please select a plot number";
    }

    return FutureBuilder<List<int?>>(
      future: getUsedPlotNums, // replace with your function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // return a loader widget
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // return an error widget
        } else if (snapshot.hasData) {
          return DropDownDefault(
            enabled: enabled,
            searchable: searchable,
            title: "Plot number",
            onBeforePopup: onBeforePopup,
            onChangedFn: (s) {
              int plotNum = int.tryParse(s ?? "-1") ?? -1;
              updatePlotNum(plotNum);
            },
            selectedItem: getSelectedItem(),
            itemsList: plotType.isEmpty ? [] : itemList,
            disabledItemFn: (s) {
              if (selectedItem != startingPlotNum && s == startingPlotNum) {
                return false;
              } else {
                return snapshot.data!.contains(int.tryParse(s ?? "-1") ?? -1);
              }
            },
          );
        } else {
          return const SizedBox(); // return an empty widget or something else
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';

class SetTransectNumBuilder extends StatelessWidget {
  const SetTransectNumBuilder({
    super.key,
    required this.getUsedTransNums,
    this.name = "Transect",
    required this.startingTransNum,
    required this.selectedItem,
    required this.transList,
    this.searchable = false,
    this.onBeforePopup,
    required this.updateTransNum,
  });

  final Future<List<int?>> getUsedTransNums;
  final String name;
  final String startingTransNum;
  final String selectedItem;
  final List<String> transList;
  final bool searchable;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(int) updateTransNum;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int?>>(
      future: getUsedTransNums, // replace with your function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // return a loader widget
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // return an error widget
        } else if (snapshot.hasData) {
          return DropDownDefault(
            searchable: searchable,
            title: name.isEmpty ? "" : "$name Number",
            onBeforePopup: onBeforePopup,
            onChangedFn: (s) {
              int transNum = int.tryParse(s ?? "-1") ?? -1;
              updateTransNum(transNum);
            },
            selectedItem: selectedItem,
            itemsList: transList,
            disabledFn: (s) {
              print("selected item: $selectedItem, starting transNum: $startingTransNum");
              if (selectedItem != startingTransNum && s == startingTransNum) {
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

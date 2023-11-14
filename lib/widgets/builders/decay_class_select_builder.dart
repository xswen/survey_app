import 'package:flutter/material.dart';

import '../../constants/constant_values.dart';
import '../dropdowns/drop_down_default.dart';

class DecayClassSelectBuilder extends StatelessWidget {
  const DecayClassSelectBuilder({
    super.key,
    this.title = "",
    required this.onChangedFn,
    required this.selectedItem,
    this.onBeforePopup,
  });

  final String title;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropDownDefault(
        padding: 0,
        title: title,
        onBeforePopup: onBeforePopup,
        onChangedFn: onChangedFn,
        itemsList: kDecayClassList,
        selectedItem:
            selectedItem.isEmpty ? "Choose Decay Class" : selectedItem);
  }
}

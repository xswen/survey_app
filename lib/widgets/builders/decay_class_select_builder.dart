import 'package:flutter/material.dart';

import '../../constants/constant_values.dart';
import '../dropdowns/drop_down_default.dart';
import '../hide_info_checkbox.dart';

class DecayClassSelectBuilder extends StatelessWidget {
  const DecayClassSelectBuilder(
      {Key? key,
      required this.title,
      required this.onChangedFn,
      required this.selectedItem,
      this.checkTitle = "Average Decay Class Missing",
      this.checkValue,
      this.onBeforePopup,
      this.checkOnChange,
      this.dependentChildren})
      : super(key: key);
  final String title;
  final String checkTitle;
  final bool? checkValue;
  final void Function(bool?)? checkOnChange;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final String selectedItem;
  final List<Widget>? dependentChildren;

  @override
  Widget build(BuildContext context) {
    String dropdownTitle = title;
    checkValue != null ? dropdownTitle = "" : null;

    DropDownDefault decayClassDropDown = DropDownDefault(
        padding: 0,
        title: dropdownTitle,
        onBeforePopup: onBeforePopup,
        onChangedFn: onChangedFn,
        itemsList: kDecayClassList,
        selectedItem: _getDecayClass(selectedItem));

    if (checkValue == null) {
      return decayClassDropDown;
    } else {
      return HideInfoCheckbox(
        title: title,
        checkTitle: checkTitle,
        checkValue: checkValue!,
        onChange: checkOnChange,
        child: dependentChildren == null
            ? decayClassDropDown
            : Column(children: [decayClassDropDown, ...dependentChildren!]),
      );
    }
  }

  String _getDecayClass(String decayClass) {
    if (decayClass.isEmpty) {
      return "Choose Decay Class";
    }

    return decayClass;
  }
}

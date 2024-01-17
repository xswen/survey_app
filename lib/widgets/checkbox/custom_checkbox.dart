import 'package:flutter/material.dart';

import '../../constants/text_designs.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {super.key,
      required this.title,
      required this.checkValue,
      this.onChange,
      this.contentPadding = EdgeInsets.zero});

  final String title;
  final bool checkValue;
  final ValueChanged<bool?>? onChange;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: title.isEmpty
          ? null
          : Text(
              title,
              style: kTextStyle,
            ),
      value: checkValue,
      onChanged: onChange,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.platform,
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants/text_designs.dart';

class CustomCheckbox extends StatefulWidget {
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
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.checkValue;
  }

  void _handleCheckboxChanged(bool? newValue) {
    if (newValue != null) {
      setState(() {
        _isChecked = newValue;
      });
      if (widget.onChange != null) {
        widget.onChange!(newValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: widget.title.isEmpty
          ? null
          : Text(
              widget.title,
              style: kTextStyle,
            ),
      value: _isChecked,
      onChanged: _handleCheckboxChanged,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.platform,
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';

class HideInfoCheckbox extends StatefulWidget {
  const HideInfoCheckbox({
    super.key,
    this.title = "",
    this.checkTitle = "",
    required this.checkValue,
    this.onChange,
    required this.child,
    this.padding = const EdgeInsets.only(top: kPaddingV * 2),
  });

  @override
  State<HideInfoCheckbox> createState() => _HideInfoCheckboxState();

  final String title;
  final String checkTitle;
  final bool checkValue;
  final ValueChanged<bool?>? onChange;
  final Widget child;
  final EdgeInsets padding;
}

class _HideInfoCheckboxState extends State<HideInfoCheckbox> {
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
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title.isNotEmpty,
            child: Text(
              widget.title,
            ),
          ),
          CheckboxListTile(
            title: widget.checkTitle.isEmpty
                ? null
                : Text(
                    widget.checkTitle,
                    style: kTextStyle,
                  ),
            value: _isChecked,
            onChanged: _handleCheckboxChanged,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.platform,
          ),
          Visibility(
            visible: !_isChecked,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

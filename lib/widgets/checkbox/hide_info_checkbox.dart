import 'package:flutter/material.dart';
import 'package:survey_app/widgets/checkbox/custom_checkbox.dart';

import '../../constants/margins_padding.dart';

class HideInfoCheckbox extends StatefulWidget {
  const HideInfoCheckbox({
    super.key,
    this.title = "",
    this.titleWidget = "",
    required this.checkValue,
    this.onChange,
    required this.child,
    this.padding = const EdgeInsets.only(top: kPaddingV * 2),
  });

  @override
  State<HideInfoCheckbox> createState() => _HideInfoCheckboxState();

  final String title;
  final String titleWidget;
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
          CustomCheckbox(
            title: widget.titleWidget,
            checkValue: _isChecked,
            onChange: _handleCheckboxChanged,
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

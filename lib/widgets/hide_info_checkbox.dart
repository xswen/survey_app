import 'package:flutter/material.dart';

import '../constants/margins_padding.dart';
import '../constants/text_designs.dart';

class HideInfoCheckbox extends StatefulWidget {
  const HideInfoCheckbox({
    Key? key,
    this.title = "",
    this.checkTitle = "",
    this.onChange,
    required this.child,
    required this.checkValue,
    this.padding = const EdgeInsets.only(top: kPaddingV * 2),
  }) : super(key: key);

  @override
  State<HideInfoCheckbox> createState() => _HideInfoCheckboxState();

  final String title;
  final String checkTitle;
  final bool checkValue;
  final void Function(bool?)? onChange;
  final Widget child;
  final EdgeInsetsGeometry padding;
}

class _HideInfoCheckboxState extends State<HideInfoCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isEmpty
              ? Container()
              : Text(widget.title, style: kTitleStyle),
          CheckboxListTile(
            title: widget.checkTitle.isEmpty
                ? Container()
                : Text(
                    widget.checkTitle,
                    style: kTextStyle,
                  ),
            value: widget.checkValue,
            onChanged: widget.onChange,
            controlAffinity: ListTileControlAffinity.platform,
          ),
          if (!widget.checkValue) widget.child,
        ],
      ),
    );
  }
}

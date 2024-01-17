import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';
import 'custom_checkbox.dart';

class MultiRowCheckbox extends StatelessWidget {
  const MultiRowCheckbox({
    super.key,
    required this.title,
    this.boxes = const [],
    required this.child,
    this.padding = const EdgeInsets.only(top: kPaddingV * 2),
  });

  final String title;
  final List<CustomCheckbox> boxes;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title.isNotEmpty,
            child: Text(
              title,
            ),
          ),
          ...boxes,
          child,
        ],
      ),
    );
  }
}

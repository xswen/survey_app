import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';

class TextHeaderSeparator extends StatelessWidget {
  const TextHeaderSeparator({
    Key? key,
    this.colAlignment = CrossAxisAlignment.start,
    this.rowAlignment = MainAxisAlignment.start,
    this.rowPadding,
    required this.title,
    this.fontSize = kTextTitleSize,
    this.sideWidget = const SizedBox(),
  }) : super(key: key);
  final CrossAxisAlignment colAlignment;
  final MainAxisAlignment rowAlignment;
  final EdgeInsetsGeometry? rowPadding;
  final String title;
  final double fontSize;
  final Widget? sideWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: colAlignment,
      children: [
        Padding(
          padding: rowPadding ??
              const EdgeInsets.symmetric(horizontal: kPaddingH / 2),
          child: Row(
            mainAxisAlignment: rowAlignment,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              sideWidget ?? const SizedBox()
            ],
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}

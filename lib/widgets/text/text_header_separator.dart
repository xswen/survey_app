import 'package:flutter/material.dart';

import '../../constants/text_designs.dart';

class TextHeaderSeparator extends StatelessWidget {
  const TextHeaderSeparator({
    Key? key,
    this.colAlignment = CrossAxisAlignment.start,
    this.rowAlignment = MainAxisAlignment.start,
    required this.title,
    this.sideWidget = const SizedBox(),
  }) : super(key: key);
  final CrossAxisAlignment colAlignment;
  final MainAxisAlignment rowAlignment;
  final String title;
  final Widget sideWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: colAlignment,
      children: [
        Row(
          mainAxisAlignment: rowAlignment,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: kTextTitleSize),
            ),
            sideWidget
          ],
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';

class SummarySectionButton extends StatelessWidget {
  const SummarySectionButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.complete})
      : super(key: key);

  final String title;
  final void Function() onPressed;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: kPaddingH, vertical: kPaddingV / 2),
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: complete
                    ? MaterialStateProperty.all<Color>(Colors.grey)
                    : null),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingH, vertical: kPaddingV),
              child: Text("$title: ${complete ? "Complete" : "Incomplete"}"),
            )));
  }
}

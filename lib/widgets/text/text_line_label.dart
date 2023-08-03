//Format so variable is on top of label
import 'package:flutter/material.dart';

class TextLineLabelBottom extends StatelessWidget {
  final Text value;
  final Text label;
  final Color lineColor;

  const TextLineLabelBottom(
      {super.key,
      required this.value,
      required this.label,
      this.lineColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(
              //using bottom property, can control the space between underline and text
              bottom: 0,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: lineColor,
                  width: 1.0,
                ),
              ),
            ),
            child: value),
        label, //Text Class
      ],
    );
  }
}

class TextLineLabelTop extends StatelessWidget {
  final Text value;
  final Text label;
  final Color lineColor;

  const TextLineLabelTop(
      {super.key,
      required this.value,
      required this.label,
      this.lineColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        value,
        Container(
            padding: const EdgeInsets.only(
              //using bottom property, can control the space between underline and text
              top: 0,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: lineColor,
                  width: 1.0,
                ),
              ),
            ),
            child: label), //Text Class
      ],
    );
  }
}

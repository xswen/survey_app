import 'package:flutter/material.dart';

class TextInLine extends StatelessWidget {
  const TextInLine({
    super.key,
    required this.label,
    required this.data,
  });
  final Widget label;
  final Widget data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        label,
        data,
      ],
    );
  }
}

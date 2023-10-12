import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';

class NotifyNoFilterResults extends StatelessWidget {
  const NotifyNoFilterResults(
      {super.key,
      this.message = "There is nothing to show. Please change filters."});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: kPaddingH),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: kTextHeaderSize),
        ),
      ),
    );
  }
}

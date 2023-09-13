import 'package:flutter/cupertino.dart';

import '../../formatters/format_string.dart';
import 'popup_dismiss.dart';

class PopupErrorsFoundList extends StatelessWidget {
  const PopupErrorsFoundList({super.key, required this.errors});

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return PopupDismiss(
      "Error: Incorrect Data",
      contentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Errors were found in the following places",
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              FormatString.generateBulletList(errors),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';

import '../../formatters/format_string.dart';

class PopupWarningMissingFieldsList extends StatelessWidget {
  const PopupWarningMissingFieldsList(
      {super.key,
      required this.missingFields,
      required this.rightBtnOnPressed});

  final List<String> missingFields;
  final void Function() rightBtnOnPressed;
  @override
  Widget build(BuildContext context) {
    return PopupContinue(
      "Warning: Submitting with missing fields",
      contentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "You are trying to submit the following data as missing.",
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              FormatString.generateBulletList(missingFields),
              textAlign: TextAlign.start,
            ),
          ),
          const Text(
            "Are you sure you want to continue?",
            textAlign: TextAlign.start,
          ),
        ],
      ),
      rightBtnOnPressed: () => rightBtnOnPressed(),
    );
  }
}

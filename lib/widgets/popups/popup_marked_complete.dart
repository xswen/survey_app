import 'package:flutter/material.dart';
import 'package:survey_app/extensions/extensions.dart';

import 'popup_dismiss.dart';

class PopupMarkedComplete extends StatelessWidget {
  const PopupMarkedComplete({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return PopupDismiss("Marked Complete",
        contentText:
            "${title.capitalizeFirstLetter()} has been marked as complete and changes"
            "will no longer be allowed\n. "
            "Please press the edit button to un-mark as complete "
            "to unlock and make any future changes.");
  }
}

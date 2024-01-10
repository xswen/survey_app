import 'package:flutter/material.dart';

import 'popup_continue.dart';

class PopupNoticeSurveyComplete extends StatelessWidget {
  const PopupNoticeSurveyComplete(
      {super.key, required this.title, required this.rightBtnOnPressed});

  final String title;
  final void Function() rightBtnOnPressed;
  @override
  Widget build(BuildContext context) {
    return PopupContinue(
      "Notice: $title has been marked as complete",
      contentText:
          "You will be able to see $title info but not make any edits. "
          "Please click edit if you want to make any changes.",
      rightBtnOnPressed: rightBtnOnPressed,
    );
  }
}

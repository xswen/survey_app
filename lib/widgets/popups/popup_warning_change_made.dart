import 'package:flutter/material.dart';

import 'popup_continue.dart';

class PopupWarningChangesUnsaved extends StatelessWidget {
  const PopupWarningChangesUnsaved(
      {super.key, required this.rightBtnOnPressed});

  final void Function() rightBtnOnPressed;

  @override
  Widget build(BuildContext context) {
    return PopupContinue(
      "Warning: Changes unsaved",
      contentText:
          "You have made changes that are unsaved. Going back will lose"
          "this data and cannot be retrieved. \n"
          "Are you sure you want to continue?",
      rightBtnOnPressed: () => rightBtnOnPressed(),
    );
  }
}

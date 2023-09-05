import 'package:flutter/material.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';

class Popups {
  static PopupDismiss generateCompleteErrorPopup(String location) => PopupDismiss(
      "Error: $location Marked as Complete",
      contentText:
          "$location has already been marked as complete. Please click 'Edit' to make any changes");

  static PopupDismiss generatePreviousMarkedCompleteErrorPopup(
          String location) =>
      PopupDismiss("Error: $location Marked as Complete",
          contentText:
              "$location has already been marked as complete. Please go back and press 'Edit' to make changes here");

  static PopupContinue generateWarningUnsavedChanges(
      void Function() rightBtnOnPressed) {
    return PopupContinue("Warning: Unsaved changes.",
        contentText:
            "Going back now will delete any changes that have been made. Are you sure you wish to continue?",
        rightBtnOnPressed: () => rightBtnOnPressed());
  }

  static show(BuildContext context, Widget popup) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return popup;
        });
  }
}

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

  static PopupContinue generateWarningMarkingAsMissing(
      void Function() rightBtnOnPressed,
      {String? extraInfo}) {
    return PopupContinue("Warning: Missing field.",
        contentText:
            "Are you sure you want to mark field as missing? ${extraInfo ?? ""}",
        rightBtnOnPressed: () => rightBtnOnPressed());
  }

  static PopupContinue generateNoticeSurveyComplete(
          String location, void Function() rightBtnOnPressed) =>
      PopupContinue(
        "Notice: $location has been marked as complete",
        contentText:
            "You will be able to see $location info but not make any edits. "
            "Please click edit if you want to make any changes.",
        rightBtnOnPressed: rightBtnOnPressed,
      );
  static void showMissingTransect(BuildContext context,
          {String cardName = "transect"}) =>
      show(
          context,
          PopupDismiss("Error Missing $cardName",
              contentText: "Please add at least one $cardName"));

  static void showIncompleteTransect(BuildContext context,
          {String cardName = "transects"}) =>
      show(
          context,
          PopupDismiss("Error: Incomplete $cardName",
              contentText:
                  "Please mark all $cardName as complete to continue"));

  static show(BuildContext context, Widget popup) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return popup;
        });
  }
}

import 'package:flutter/material.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';

class Popups {
  static showDismiss(BuildContext context, String title,
      {String? contentText, Widget? contentWidget, String? buttonTitle}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return PopupDismiss(title,
              contentText: contentText,
              contentWidget: contentWidget,
              buttonTitle: buttonTitle);
        });
  }

  static showContinue(BuildContext context, String title, String content,
      {Object? cancelResult, VoidCallback? rightBtnOnPressed}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return PopupContinue(title, content,
              cancelResult: cancelResult, rightBtnOnPressed: rightBtnOnPressed);
        });
  }

  static PopupDismiss generateCompleteErrorPopup(
          BuildContext context, String location) =>
      PopupDismiss("Error: $location Marked as Complete",
          contentText:
              "$location has already been marked as complete. Please click 'Edit' to make any changes");

  static PopupDismiss generatePreviousMarkedCompleteErrorPopup(
          BuildContext context, String location) =>
      PopupDismiss("Error: $location Marked as Complete",
          contentText:
              "$location has already been marked as complete. Please go back and press 'Edit' to make changes here");

  static show(BuildContext context, Widget popup) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return popup;
        });
  }
}

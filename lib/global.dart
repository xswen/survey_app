import 'package:drift/drift.dart' as d;

import 'widgets/popups/popup_dismiss.dart';

mixin Global {
  static String globalLocale = "en_CA";
  static String nullableToStr(value) => value?.toString() ?? "";
  static String dbCompanionValueToStr(value) => (value == null ||
          value == const d.Value.absent() ||
          value == const d.Value(null))
      ? ""
      : value.value.toString();

  static PopupDismiss generateCompleteErrorPopup(String location) => PopupDismiss(
      title: "Error: $location Marked as Complete",
      contentText:
          "$location has already been marked as complete. Please click 'Edit' to make any changes");

  static PopupDismiss generatePreviousMarkedCompleteErrorPopup(
          String location) =>
      PopupDismiss(
          title: "Error: $location Marked as Complete",
          contentText:
              "$location has already been marked as complete. Please go back and press 'Edit' to make changes here");
}

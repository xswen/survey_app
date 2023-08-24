import 'package:drift/drift.dart' as d;

import 'widgets/popups/popup_dismiss_dep.dart';

mixin Global {
  static String globalLocale = "en_CA";
  static String nullableToStr(value) => value?.toString() ?? "";
  static String dbCompanionValueToStr(value) => (value == null ||
          value == const d.Value.absent() ||
          value == const d.Value(null))
      ? ""
      : value.value.toString();

  static PopupDismissDep generateCompleteErrorPopup(String location) =>
      PopupDismissDep(
          title: "Error: $location Marked as Complete",
          contentText:
              "$location has already been marked as complete. Please click 'Edit' to make any changes");

  static PopupDismissDep generatePreviousMarkedCompleteErrorPopup(
          String location) =>
      PopupDismissDep(
          title: "Error: $location Marked as Complete",
          contentText:
              "$location has already been marked as complete. Please go back and press 'Edit' to make changes here");
}

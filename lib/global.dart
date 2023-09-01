import 'package:drift/drift.dart' as d;

mixin Global {
  static String globalLocale = "en_CA";
  static String nullableToStr(value) => value?.toString() ?? "";
  static String dbCompanionValueToStr(value) => (value == null ||
          value == const d.Value.absent() ||
          value == const d.Value(null))
      ? ""
      : value.value.toString();
}

mixin Global {
  static String globalLocale = "en_CA";
  static String nullableToStr(value) => value?.toString() ?? "";
}

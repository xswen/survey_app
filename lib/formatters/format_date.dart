import 'package:intl/intl.dart';

class FormatDate {
  static String toStr(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  static DateTime toDate(String str) {
    return DateTime.parse(str);
  }
}

import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
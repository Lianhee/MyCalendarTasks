import 'package:intl/intl.dart';

class Days {
  static DateFormat format = DateFormat('MMM d EEE');

  /* Days difference:
   * 0 --> Today
   * > 0 --> Next days
   * < 0 --> Previous days
  */

  static int diffDays({required DateTime now, required DateTime date}) {
    int dayDiff = date.day - now.day;
    int monthDiff = (date.month - now.month) * 30;
    int yearDiff = (date.year - now.year) * 365;
    return yearDiff + monthDiff + dayDiff;
  }
}

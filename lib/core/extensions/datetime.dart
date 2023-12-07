import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String time(bool use24HourFormat) {
    if (use24HourFormat) {
      //24h format
      return DateFormat('HH:mm').format(this);
    } else {
      //12h format
      return DateFormat('h:mm a').format(this);
    }
  }
}
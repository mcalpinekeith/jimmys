import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String time(bool use24HourFormat) => DateFormat((use24HourFormat ? 'HH:mm' : 'h:mm a')).format(this);
}
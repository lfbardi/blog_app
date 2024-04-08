import 'package:intl/intl.dart';

String formatDateBydMMMyyyy(DateTime date) {
  return DateFormat('d MMM, yyy').format(date);
}

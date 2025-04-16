import 'dart:math';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class DatedCacheEntry {
  Id? cacheKey;
  List<String>? values;
}

int genCacheKey(DateTime date, int studentId) {
  var md = date.month * pow(10, 2) + date.day;

  return (md * pow(10, 11) + studentId) as int;
}

DateTime getDate(int key) {
  var currentDate = DateTime.now();
  var md = key ~/ pow(10, 11);
  var month = md ~/ pow(10, 2);
  var day = md - month * pow(10, 2);

  return DateFormat("yyyy-M-d").parse("${currentDate.year}-$month-$day");
}

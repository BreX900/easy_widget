import 'package:flutter/material.dart';

class DateTimeUtility {
  static String toDate(DateTime dateTime,
      {String separator: '-', bool year: true, bool month: true, bool day: true}) {
    return [
      if (year) dateTime.year,
      if (month) dateTime.month,
      if (day) dateTime.day,
    ].join(separator);
  }

  static String toTime(DateTime dateTime,
      {bool hour: true, bool minute: true, bool second: true, bool millisecond: false}) {
    return dateTime == null
        ? ""
        : [
              if (hour) dateTime.hour,
              if (minute) dateTime.minute,
              if (second) dateTime.second,
            ].join(":") +
            (millisecond ? '.${dateTime.millisecond}' : '');
  }

  static TimeOfDay toTimeOfDay(DateTime dateTime) {
    return TimeOfDay.fromDateTime(dateTime);
  }

  static DateTime byDateAndTime(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute, time.second,
        time.millisecond, time.microsecond);
  }

  static DateTime copyWith(DateTime dateTime,
      {int year, int month, int hour, int day, int minute, int second, int millisecond, int microsecond}) {
    return DateTime(
      year ?? dateTime.year,
      month ?? dateTime.month,
      day ?? dateTime.day,
      hour ?? dateTime.hour,
      minute ?? dateTime.minute,
      second ?? dateTime.second,
      millisecond ?? dateTime.millisecond,
      microsecond ?? dateTime.microsecond,
    );
  }

  static DateTime basicCopyWith(DateTime dateTime, {int leading, int middle, int trailing}) {
    return copyWith(dateTime,
        year: leading,
        month: leading,
        day: leading,
        hour: middle,
        minute: middle,
        second: middle,
        millisecond: trailing,
        microsecond: trailing);
  }
}

//class DateTimePrinter {
//  final bool year, month, day;
//  final bool hour, minute, second, millisecond;
//  final String timeSeparator, dateSeparator, separator;
//
//  DateTimePrinter({
//    this.dateSeparator: '-', this.separator: ' ', this.timeSeparator: ':',
//    this.year: true, this.month: true, this.day: true,
//    this.hour: true, this.minute: true, this.second: true, this.millisecond: false,
//  });
//
//  DateTimePrinter.time()
//
//  String _threeDigits(int n) {
//    if (n >= 100) return "${n}";
//    if (n >= 10) return "0${n}";
//    return "00${n}";
//  }
//
//  String _twoDigits(int n) {
//    if (n >= 10) return "${n}";
//    return "0${n}";
//  }
//
//  String toDate(DateTime dateTime) {
//    return [
//      if (year) dateTime.year,
//      if (month) dateTime.month,
//      if (day) dateTime.day,
//    ].join(separator);
//  }
//
//  String toTime(DateTime dateTime) {
//    return dateTime == null
//        ? ""
//        : [
//      if (hour) dateTime.hour,
//      if (minute) dateTime.minute,
//      if (second) dateTime.second,
//    ].join(":") +
//        (millisecond ? '.${dateTime.millisecond}' : '');
//  }
//}
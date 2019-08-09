import 'package:flutter/material.dart';


typedef void OpenScreen(BuildContext context, Widget screen);

typedef ImageProvider ImgBuilder(int index);

typedef R ListBuilder<K, V, R>(K key, V value);

List<R> mapToList<K, V, R>(Map<K, V> map, ListBuilder<K, V, R> listBuilder) {
  final list = List<R>();
  map.forEach((K key, V value) => list.add(listBuilder(key, value)));
  return list;
}


class DateTimeUtility {
  static String toDate(DateTime dateTime, {String separator: '-', bool year: true, bool month: true, bool day: true}) {
    return [
      if (year) dateTime.year,
      if (month) dateTime.month,
      if (day) dateTime.day,
    ].join(separator);
  }
  static String toTime(DateTime dateTime, {bool hour: true, bool minute: true, bool second: true, bool millisecond: false}) {
    return [
      if (hour) dateTime.hour,
      if (minute) dateTime.minute,
      if (second) dateTime.second,
    ].join(":")+(millisecond ? dateTime.millisecond : '');
  }
  static TimeOfDay toTimeOfDay(DateTime dateTime) {
    return TimeOfDay.fromDateTime(dateTime);
  }
  static DateTime byDateAndTime(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute, time.second, time.millisecond, time.microsecond);
  }
}



typedef void EventInner(event);

class Event {
  final String code;

  Event(this.code);
}

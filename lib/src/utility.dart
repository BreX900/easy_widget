import 'package:flutter/material.dart';


typedef void OpenScreen(BuildContext context, Widget screen);

typedef ImageProvider ImgBuilder(int index);

typedef R ListBuilder<K, V, R>(K key, V value);

List<R> mapToList<K, V, R>(Map<K, V> map, ListBuilder<K, V, R> listBuilder) {
  final list = List<R>();
  map.forEach((K key, V value) => list.add(listBuilder(key, value)));
  return list;
}


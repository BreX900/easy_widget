import 'package:flutter/cupertino.dart';

class ListUtility {
  static List<E> joiner<E>(List<E> list, E builder(int index)) {
    if (list.length == 1) return list.toList();
    final length = (list.length * 2) - 1;
    final newList = List<E>()..length = length;
    for (int i = 0; i < (list.length - 1); i++) {
      final index = i * 2;
      newList
        ..[index] = list[i]
        ..[index + 1] = builder(i);
    }
    return newList..[length - 1] = list.last;
  }

  static List<E> nullGenerator<E>(E builder(int index), {int itemCount}) {
    if (itemCount != null) return List.generate(itemCount, builder);
    E element = builder(0);
    if (element == null) return <E>[];
    List<E> newList = <E>[element];
    for (int i = 1; element != null; i++) {
      newList..add(element);
      element = builder(i);
    }
    return newList;
  }
}

class WidgetBuilderUtility {
  static IndexedWidgetBuilder builderWithSeparator(
      IndexedWidgetBuilder builder, IndexedWidgetBuilder separatorBuilder,
      {bool surround: false}) {
    if (separatorBuilder == null) return builder;

    return (context, index) {
      final itemIndex = index ~/ 2;
      if (surround ? !(index % 2 == 0) : (index % 2 == 0))
        return builder(context, itemIndex);
      else
        return separatorBuilder(context, itemIndex);
    };
  }

  static int separatorCount(int childCount, [bool surround = false]) {

    return childCount > 0 ? ((childCount > 1 ? childCount-1 : 0) + (surround ? 2 : 0)) : 0;
  }

  static int childCount(int childCount, bool existSeparator, {bool surround: false}) {
    return childCount + (existSeparator ? separatorCount(childCount, surround) : 0);
  }
}

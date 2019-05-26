import 'package:flutter/widgets.dart';

class SliverListSeparatorDelegate extends SliverChildBuilderDelegate {

  SliverListSeparatorDelegate.builder({
    @required IndexedWidgetBuilder builder,
    @required IndexedWidgetBuilder separatorBuilder,
    @required int childCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
  }) : super((context, index) {
    if (index%2 == 0)
      return builder(context, index);
    else
      return separatorBuilder(context, index);
  },
    childCount: _childrenCount(childCount),
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (Widget _, int localIndex) => localIndex,
    semanticIndexOffset: semanticIndexOffset,
  );

  static int _childrenCount(int length) {
    return length > 1 ? length*2-1 : length;
  }

  SliverListSeparatorDelegate.childrenBuilder({
    @required IndexedWidgetBuilder builder,
    @required int childCount,
    @required Widget separator,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
  }) : this.builder(
    builder: (context, index) {
      return builder(context, index~/2);
    },
    childCount: childCount,
    separatorBuilder: (_, __) => separator,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (Widget _, int localIndex) => localIndex,
    semanticIndexOffset: semanticIndexOffset,
  );

  SliverListSeparatorDelegate({
    @required List<Widget> children,
    @required Widget separator,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
  }) : this.childrenBuilder(
    childCount: children.length,
    builder: (context, index) => children[index],
    separator: separator,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (Widget _, int localIndex) => localIndex,
    semanticIndexOffset: semanticIndexOffset,
  );

}
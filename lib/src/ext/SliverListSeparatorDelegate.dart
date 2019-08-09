import 'package:flutter/widgets.dart';

class SliverListSeparatorDelegate extends SliverChildBuilderDelegate {

  SliverListSeparatorDelegate.builder(IndexedWidgetBuilder builder, {
    @required IndexedWidgetBuilder separatorBuilder,
    @required int childCount,
    bool startWithDivider: false,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
  }) : assert(startWithDivider != null), super((context, index) {
    if (separatorBuilder == null || (index+(startWithDivider?1:0))%2 == 0)
      return builder(context, index);
    else
      return separatorBuilder(context, index);
  },
    childCount: separatorBuilder == null ? childCount : _childrenCount(childCount+(startWithDivider?1:0)),
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (Widget _, int localIndex) => localIndex,
    semanticIndexOffset: semanticIndexOffset,
  );

  static int _childrenCount(int length) {
    return (length > 1 ? length*2-1 : length);
  }

  SliverListSeparatorDelegate.childrenBuilder(IndexedWidgetBuilder builder, {
    @required int childCount,
    @required Widget separator,
    bool startWithDivider: false,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
  }) : this.builder((context, index) {
      return builder(context, separator == null ? index : index~/2);
    },
    childCount: childCount,
    separatorBuilder: separator == null ? null : (_, __) => separator,
    startWithDivider: startWithDivider,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (Widget _, int localIndex) => localIndex,
    semanticIndexOffset: semanticIndexOffset,
  );

  SliverListSeparatorDelegate(List<Widget> children, {
    @required Widget separator,
    bool startWithDivider: false,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
  }) : this.childrenBuilder((context, index) => children[index],
    childCount: children.length,
    separator: separator,
    startWithDivider: startWithDivider,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (Widget _, int localIndex) => localIndex,
    semanticIndexOffset: semanticIndexOffset,
  );

}
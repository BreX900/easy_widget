import 'package:easy_widget/src/utility/ListUtility.dart';
import 'package:flutter/widgets.dart';

class SliverLayoutDelegate extends SliverChildBuilderDelegate {
//  SliverLayoutDelegate({
//    bool addAutomaticKeepAlives = true,
//    bool addRepaintBoundaries = true,
//    bool addSemanticIndexes = true,
//    SemanticIndexCallback semanticIndexCallback,
//    int semanticIndexOffset = 0,
//    @required int childCount,
//    @required IndexedWidgetBuilder builder,
//  })  : assert(builder != null),
//        assert(childCount != null),
//        super(
//          builder,
//          childCount: childCount,
//          addAutomaticKeepAlives: addAutomaticKeepAlives,
//          addRepaintBoundaries: addRepaintBoundaries,
//          addSemanticIndexes: addSemanticIndexes,
//          semanticIndexCallback: (Widget _, int localIndex) => localIndex,
//          semanticIndexOffset: semanticIndexOffset,
//        );

  SliverLayoutDelegate({
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
    @required int childCount,
    bool surround: false,
    IndexedWidgetBuilder separatorBuilder,
    @required IndexedWidgetBuilder builder,
  })  : assert(surround != null),
        assert(builder != null),
        assert(childCount != null),
        super(
          (separatorBuilder == null
              ? builder
              : WidgetBuilderUtility.builderWithSeparator(
                  builder,
                  separatorBuilder,
                  surround: surround,
                )),
          childCount: WidgetBuilderUtility.childCount(
            childCount,
            separatorBuilder != null,
            surround: surround,
          ),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (Widget _, int localIndex) => localIndex,
          semanticIndexOffset: semanticIndexOffset,
        );

  factory SliverLayoutDelegate.childrenBuilder({
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
    bool surround: false,
    @required int childCount,
    @required Widget separator,
    @required IndexedWidgetBuilder builder,
  }) {
    assert(separator != null);
    return SliverLayoutDelegate(
      surround: surround,
      childCount: childCount,
      separatorBuilder: (_, __) => separator,
      builder: builder,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      semanticIndexCallback: (Widget _, int localIndex) => localIndex,
      semanticIndexOffset: semanticIndexOffset,
    );
  }

  factory SliverLayoutDelegate.children({
    bool surround: false,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback semanticIndexCallback,
    int semanticIndexOffset = 0,
    Widget separator,
    @required List<Widget> children,
  }) {
    return SliverLayoutDelegate(
      surround: surround,
      builder: (context, index) => children[index],
      childCount: children.length,
      separatorBuilder: separator == null ? null : (_, __) => separator,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      semanticIndexCallback: (Widget _, int localIndex) => localIndex,
      semanticIndexOffset: semanticIndexOffset,
    );
  }
}

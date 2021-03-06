import 'package:easy_widget/easy_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SliverContainer extends StatelessWidget {
  final EdgeInsets padding;
  final Widget sliver;

  const SliverContainer._({
    Key key,
    this.padding,
    @required this.sliver,
  })  : assert(sliver != null),
        super(key: key);

  SliverContainer.adapter({
    Key key,
    @required Widget child,
    this.padding,
  }) : this.sliver = SliverToBoxAdapter(
          child: child,
        );

//  SliverLayout.listBuilder(IndexedWidgetBuilder builder, {Key key,
//    this.padding,
//    @required int childCount,
//    bool startWithDivider: false,
//    Widget separator,
//  }) : assert(builder != null), this.sliver = SliverList(
//    delegate: SliverListSeparatorDelegate.childrenBuilder(
//      builder, childCount: childCount,
//      startWithDivider: startWithDivider, separator: separator,
//    ),
//  );
//
//  SliverLayout.listChildren(List<Widget> children, {Key key,
//    this.padding,
//    Widget separator,
//  }) : assert(children != null), this.sliver = SliverList(
//    delegate: SliverListSeparatorDelegate(children,
//      separator: separator,
//    ),
//  );

  @override
  Widget build(BuildContext context) {
    return padding == null
        ? sliver
        : SliverPadding(
            padding: padding,
            sliver: sliver,
          );
  }
}

class ScrollLayout extends ScrollView {
  final EdgeInsets padding;
  final int childCount;
  final Widget separator;
  final IndexedWidgetBuilder builder;

  ScrollLayout._({
    Key key,
    Axis scrollDirection: Axis.vertical,
    bool reverse: false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap: false,
    Key center,
    double anchor = 0.0,
    double cacheExtent,
    this.padding,
    this.childCount,
    this.separator,
    @required this.builder,
    int semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  })  : assert(builder != null),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          center: center,
          anchor: anchor,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
        );

  ScrollLayout.vertical({
    Key key,
    bool reverse: false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap: false,
    Key center,
    double anchor = 0.0,
    double cacheExtent,
    int semanticChildCount,
    DragStartBehavior dragStartBehavior: DragStartBehavior.start,
    EdgeInsets padding,
    int childCount,
    Widget separator,
    @required IndexedWidgetBuilder builder,
  }) : this._(
          key: key,
          scrollDirection: Axis.vertical,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          center: center,
          anchor: anchor,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          padding: padding,
          childCount: childCount,
          separator: separator,
          builder: builder,
        );

  ScrollLayout.horizontal({
    Key key,
    bool reverse: false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap: false,
    Key center,
    double anchor = 0.0,
    double cacheExtent,
    int semanticChildCount,
    DragStartBehavior dragStartBehavior: DragStartBehavior.start,
    EdgeInsets padding,
    int childCount,
    Widget separator,
    @required IndexedWidgetBuilder builder,
  }) : this._(
          key: key,
          scrollDirection: Axis.horizontal,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          center: center,
          anchor: anchor,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          padding: padding,
          childCount: childCount,
          separator: separator,
          builder: builder,
        );

  @override
  List<Widget> buildSlivers(BuildContext context) {
    final childCount = WidgetBuilderUtility.childCount(this.childCount, separator != null);
    IndexedWidgetBuilder builder = this.builder;
    if (padding != null)
      builder = (context, index) {
        final sliver = this.builder(context, index);
        if (index == 0)
          return SliverPadding(
            padding: padding.copyWith(bottom: 0),
            sliver: sliver,
          );
        else if (childCount == null ? sliver == null : childCount >= index) {
          return SliverPadding(
            padding: padding.copyWith(top: 0),
            sliver: sliver,
          );
        } else {
          return SliverPadding(
            padding: padding.copyWith(top: 0, bottom: 0),
            sliver: sliver,
          );
        }
      };
    if (separator != null)
      builder = WidgetBuilderUtility.builderWithSeparator(builder, (_, __) => separator);

    return ListUtility.nullGenerator(
      (index) => builder(context, index),
      itemCount: childCount == null ? null : childCount,
    );
  }
}

class SliverListLayout extends SliverContainer {
  SliverListLayout.delegate({
    EdgeInsets padding,
    @required SliverChildDelegate delegate,
  }) : super._(
          sliver: SliverList(
            delegate: delegate,
          ),
          padding: padding,
        );

//  SliverLayout({
//    EdgeInsets padding,
//    @required int childCount,
//    @required IndexedWidgetBuilder builder,
//  }) : this.delegate(
//    delegate: SliverLayoutDelegate(
//      childCount: childCount,
//      builder: builder,
//    ),
//  );

  SliverListLayout({
    EdgeInsets padding,
    bool surround: false,
    IndexedWidgetBuilder separatorBuilder,
    @required int childCount,
    @required IndexedWidgetBuilder builder,
  }) : this.delegate(
          padding: padding,
          delegate: SliverLayoutDelegate(
            separatorBuilder: separatorBuilder,
            surround: surround,
            childCount: childCount,
            builder: builder,
          ),
        );

  SliverListLayout.childrenBuilder({
    EdgeInsets padding,
    bool surround: false,
    @required int childCount,
    @required Widget separator,
    @required IndexedWidgetBuilder builder,
  }) : this.delegate(
          padding: padding,
          delegate: SliverLayoutDelegate.childrenBuilder(
            surround: surround,
            childCount: childCount,
            separator: separator,
            builder: builder,
          ),
        );

  SliverListLayout.children({
    EdgeInsets padding,
    bool surround: false,
    Widget separator,
    @required List<Widget> children,
  }) : this.delegate(
          padding: padding,
          delegate: SliverLayoutDelegate.children(
            surround: surround,
            children: children,
            separator: separator,
          ),
        );
}

//class SliverPad extends SliverPadding {
//  SliverPad.zero(Widget sliver, {
//    Key key,
//  }) : super(key: key,
//      padding: EdgeInsets.zero,
//      sliver: sliver,
//  );
//
//  SliverPad.adapter({Key key,
//    @required Widget child,
//    @required EdgeInsets padding,
//  }) : super(key: key,
//    padding: padding,
//    sliver: SliverToBoxAdapter(
//      child: child,
//    )
//  );
//
//  SliverPad.list({Key key,
//    @required SliverChildDelegate delegate,
//    @required EdgeInsets padding,
//  }) : super(key: key,
//    padding: padding,
//    sliver: SliverList(
//      delegate: delegate,
//    ),
//  );
//
//  SliverPad.listBuilder(IndexedWidgetBuilder builder, {Key key,
//    @required EdgeInsets padding,
//    int childCount,
//    Widget separator,
//  }) : super(key: key,
//    padding: padding,
//    sliver: SliverList(
//      delegate: SliverListSeparatorDelegate.childrenBuilder(
//        builder, childCount: childCount, separator: separator,
//      ),
//    ),
//  );
//
//  SliverPad.listChildren(List<Widget> children, {Key key,
//    @required EdgeInsets padding,
//    Widget separator,
//  }) : super(key: key,
//    padding: padding,
//    sliver: SliverList(
//      delegate: SliverListSeparatorDelegate(children,
//        separator: separator,
//      ),
//    ),
//  );
//}

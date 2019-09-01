import 'package:easy_widget/easy_widget.dart';
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

class SliverLayout extends SliverContainer {
  SliverLayout.delegate({
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

  SliverLayout({
    EdgeInsets padding,
    bool surround: false,
    @required int childCount,
    @required IndexedWidgetBuilder builder,
  }) : this.delegate(
    padding: padding,
          delegate: SliverLayoutDelegate(
            surround: surround,
            childCount: childCount,
            builder: builder,
          ),
        );

  SliverLayout.childrenBuilder({
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

  SliverLayout.children({
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

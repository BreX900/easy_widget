import 'package:easy_widget/easy_widget.dart';
import 'package:flutter/cupertino.dart';


class SliverLayout extends StatelessWidget {
  final EdgeInsets padding;
  final Widget sliver;

  const SliverLayout._({Key key,
    this.padding, @required this.sliver,
  }) : assert(sliver != null), super(key: key);

  SliverLayout.adapter({Key key,
    @required Widget child,
    @required this.padding,
  }) : this.sliver = SliverToBoxAdapter(
    child: child,
  );

  SliverLayout.listBuilder(IndexedWidgetBuilder builder, {Key key,
    this.padding,
    int childCount,
    Widget separator,
  }) : assert(builder != null), this.sliver = SliverList(
    delegate: SliverListSeparatorDelegate.childrenBuilder(
      builder, childCount: childCount, separator: separator,
    ),
  );

  SliverLayout.listChildren(List<Widget> children, {Key key,
    this.padding,
    Widget separator,
  }) : assert(children != null), this.sliver = SliverList(
    delegate: SliverListSeparatorDelegate(children,
      separator: separator,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return padding == null ? sliver : SliverPadding(
      padding: padding,
      sliver: sliver,
    );
  }
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
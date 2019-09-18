import 'package:easy_widget/easy_widget.dart';
import 'package:easy_widget/src/ext/pockets.dart';
import 'package:easy_widget/src/utility/ListUtility.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class Layout extends StatelessWidget {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;

  final FlexiblePocket flexible;
  final EdgeInsets padding, margin;
  final Decoration background, foreground;
  final ScrollPocket scrollPocket;

  final Widget separator;
  final List<Widget> children;

  Layout.vertical({
    Key key,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
    this.textBaseline,
    this.separator,
    this.padding,
    this.background,
    this.foreground,
    this.margin,
    this.scrollPocket,
    this.flexible,
    this.children,
  })  : this.direction = Axis.vertical,
        super(
          key: key,
        );

  Layout.horizontal({
    Key key,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
    this.textBaseline,
    this.separator,
    this.padding,
    this.background,
    this.foreground,
    this.margin,
    this.scrollPocket,
    this.flexible,
    this.children,
  })  : this.direction = Axis.horizontal,
        super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> children = this.children;
    /*expanded
        ? this.children.map((child) {
            return Expanded(child: child);
          }).toList()
        : this.children;*/
    if (separator != null) children = ListUtility.joiner(this.children, (_) => separator);

    Widget child = Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );

    if (scrollPocket != null)
      child = SingleChildScrollView(
        reverse: scrollPocket.reverse,
        padding: padding,
        primary: scrollPocket.primary,
        physics: scrollPocket.physics,
        controller: scrollPocket.controller,
        dragStartBehavior: scrollPocket.dragStartBehavior,
        child: child,
      );
    else if (padding != null) child = Padding(padding: padding, child: child);

    child = DecoratedBoxPocket.toWidget(child, background, foreground);

    if (margin != null) child = Padding(padding: margin, child: child);
    if (flexible != null) child = flexible.toWidget(child);

    return child;
  }
}

class DoubleWidget extends StatelessWidget {
  final EdgeInsets padding;
  final Widget left, separator, right;

  const DoubleWidget({
    Key key,
    this.padding,
    @required this.left,
    this.separator,
    this.right,
  }) : super(key: key);

//  static Widget sliverAdapter(
//      {EdgeInsets padding, @required Widget left, Widget separator, Widget right}) {
//    return SliverContainer.adapter(
//      child: DoubleWidget(left: left, separator: separator, right: right),
//      padding: padding,
//    );
//  }

  @override
  Widget build(BuildContext context) {
    final child = right == null
        ? left
        : Row(
            children: <Widget>[
              Expanded(child: left),
              separator,
              Expanded(child: right),
            ],
          );

    return padding == null ? child : Padding(padding: padding, child: child);
  }
}

//class LayoutPocket {
//  final Axis direction;
//  final MainAxisAlignment mainAxisAlignment;
//  final MainAxisSize mainAxisSize;
//  final CrossAxisAlignment crossAxisAlignment;
//  final TextDirection textDirection;
//  final VerticalDirection verticalDirection;
//  final TextBaseline textBaseline;
//  final Widget separator;
//  final EdgeInsets padding;
//  final ScrollPocket scrollPocket;
//
//  const LayoutPocket({
//    this.direction: Axis.vertical,
//    this.mainAxisAlignment: MainAxisAlignment.start,
//    this.mainAxisSize: MainAxisSize.max,
//    this.crossAxisAlignment: CrossAxisAlignment.center,
//    this.textDirection,
//    this.verticalDirection: VerticalDirection.down,
//    this.textBaseline,
//    this.separator,
//    this.padding,
//    this.scrollPocket,
//  });
//}

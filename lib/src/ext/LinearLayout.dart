import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';


class LinearLayout extends StatelessWidget {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;
  final List<Widget> children;

  final Widget separator;

  final EdgeInsets padding;

  final ScrollPocket scrollPocket;

  LinearLayout(List<Widget> children, {Key key,
    this.direction: Axis.vertical,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
    this.textBaseline,
    this.separator,
    this.padding,
    this.scrollPocket,
  }) : this.children = separator == null
      ? children : List.generate(_childrenCount(children.length), (index) {
    return (index % 2) == 0 ? children[index~/2] : separator;
  }), super(key: key);

  static int _childrenCount(int length) {
    return (length > 1 ? length*2-1 : length);
  }

  @override
  Widget build(BuildContext context) {

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
    else if (padding != null)
      child = Padding(
        padding: padding,
        child: child,
      );

    return child;
  }
}


class ScrollPocket {
  final bool reverse;
  final bool primary;
  final ScrollPhysics physics;
  final ScrollController controller;
  final DragStartBehavior dragStartBehavior;

  const ScrollPocket({
    this.reverse: false,
    this.primary,
    this.physics,
    this.controller,
    this.dragStartBehavior: DragStartBehavior.start,
  });
}
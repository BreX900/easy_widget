import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget decorateWithPocket(
  Widget child, {
  @required FlexiblePocket flexible,
  @required AlignPocket align,
  @required InkWellPocket inkWell,
}) {
  assert(align == null || flexible == null);
  if (flexible != null) {
    child = flexible.toWidget(child);
    if (inkWell != null) child = inkWell.toWidget(child);
  } else {
    if (inkWell != null) child = inkWell.toWidget(child);
    if (align != null) child = align.toWidget(child);
  }
  return child;
}

abstract class LegoPocket {
  Widget toWidget(Widget child);
}

abstract class DecoratedBoxPocket {
  static Widget toWidget(Widget child, Decoration background, Decoration foreground) {
    if (background != null)
      child = DecoratedBox(
        position: DecorationPosition.background,
        decoration: background,
        child: child,
      );
    if (foreground != null)
      child = DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: foreground,
        child: child,
      );
    return child;
  }
}

class FlexiblePocket implements LegoPocket {
  final int flex;
  final FlexFit fit;

  const FlexiblePocket({this.flex: 1, this.fit: FlexFit.loose});
  const FlexiblePocket.expand({this.flex: 1}) : this.fit = FlexFit.tight;

  Widget toWidget(Widget child) {
    return Flexible(
      flex: flex,
      fit: fit,
      child: child,
    );
  }
}

class AlignPocket implements LegoPocket {
  final AlignmentGeometry alignment;
  final double widthFactor;
  final double heightFactor;

  const AlignPocket({this.alignment: Alignment.center, this.widthFactor, this.heightFactor});

  Widget toWidget(Widget child) {
    return Align(
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: child,
    );
  }
}

class InkWellPocket {
  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapCallback onTapCancel;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final ValueChanged<bool> onHighlightChanged;
  final ValueChanged<bool> onHover;
  final double radius;
  final BorderRadius borderRadius;
  final ShapeBorder customBorder;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final InteractiveInkFeatureFactory splashFactory;
  final bool enableFeedback;
  final bool excludeFromSemantics;

  const InkWellPocket({
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onHighlightChanged,
    this.onHover,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
    this.enableFeedback,
    this.excludeFromSemantics,
  });

  Widget toWidget(Widget child) {
    return InkWell(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      radius: radius,
      borderRadius: borderRadius,
      customBorder: customBorder,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      enableFeedback: enableFeedback,
      excludeFromSemantics: excludeFromSemantics,
    );
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

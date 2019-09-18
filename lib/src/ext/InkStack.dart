import 'package:easy_widget/src/ext/pockets.dart';
import 'package:flutter/material.dart';

class Lego extends StatelessWidget {
  final Alignment alignment;

  final EdgeInsets padding;
  final FlexiblePocket flexible;
  final InkWellPocket inkWell;
  final List<Widget> children;

  const Lego({
    Key key,
    this.alignment: Alignment.center,
    this.padding,
    this.flexible,
    this.inkWell,
    this.children: const [],
  }) : super(key: key);

  Lego.child({
    Key key,
    this.alignment: Alignment.center,
    this.padding,
    this.flexible,
    this.inkWell,
    @required Widget child,
  })  : assert(child != null),
        this.children = [child],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      alignment: alignment,
      children: inkWell == null
          ? children
          : <Widget>[
              ...children,
              if (inkWell != null)
                Material(
                  color: Colors.transparent,
                  child: inkWell.toWidget(null),
                ),
            ],
    );

    if (padding != null) child = Padding(padding: padding, child: child);
    if (flexible != null) child = flexible.toWidget(child);

    return child;
  }
}

class Frame extends Container {
  final InkWellPocket inkWell;
  final AlignPocket align;
  final FlexiblePocket flexible;

  Frame({
    Key key,
    this.align,
    this.flexible,
    this.inkWell,
    Alignment alignment,
    EdgeInsets padding,
    Color color,
    Decoration decoration,
    double width,
    double height,
    BoxConstraints constraints,
    EdgeInsets margin,
    Widget child,
  })  : assert(align == null || flexible == null),
        super(
          key: key,
          alignment: alignment,
          padding: padding,
          color: color,
          decoration: decoration,
          width: width,
          height: height,
          constraints: constraints,
          margin: margin,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    return decorateWithPocket(
      super.build(context),
      flexible: flexible,
      align: align,
      inkWell: inkWell,
    );
  }
}

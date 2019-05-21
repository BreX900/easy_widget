import 'package:flutter/material.dart';


/// Define position line
enum PosLine {
  LEFT, BOTH, RIGHT,
}
/// Used with [ProgressTabBar] to draw a horizontal line below the
/// selected tab.
///
/// The selected tab underline is inset from the tab's boundary by [insets].
/// The [line] defines the line's color and weight.
///
/// The [TabBar.indicatorSize] property can be used to define the indicator's
/// bounds in terms of its (centered) widget with [TabIndicatorSize.label],
/// or the entire tab with [TabIndicatorSize.tab].
class ConnectLineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  /// The [line] and [insets] arguments must not be null.
  const ConnectLineTabIndicator({
    this.line: const BorderSide(width: 2.0, color: Colors.white),
    this.circle: const BorderSide(width: 0.0, color: Colors.white70),
    this.posLine: PosLine.BOTH,
  });

  /// The color and weight of the horizontal and circle line drawn.
  /// The color and weight of the background circle drawn
  final BorderSide line, circle;

  /// The position line draw [PosLine]
  final PosLine posLine;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is ConnectLineTabIndicator) {
      return ConnectLineTabIndicator(
        line: BorderSide.lerp(a.line, line, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is ConnectLineTabIndicator) {
      return ConnectLineTabIndicator(
        line: BorderSide.lerp(line, b.line, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([ VoidCallback onChanged ]) {
    return _UnderlinePainter(this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.dc, VoidCallback onChanged)
      : assert(dc != null),
        super(onChanged);

  final ConnectLineTabIndicator dc;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    final rect = offset & configuration.size;
    final Paint linePaint = dc.line.toPaint()..strokeCap = StrokeCap.butt;

    var radius = configuration.size.height/2;
    final heightBorder = rect.top + rect.height / 2;

    // Paint line
    if (dc.posLine != PosLine.LEFT)
      canvas.drawLine(
        Offset(rect.center.dx+radius, heightBorder),
        Offset(rect.right, heightBorder),
        linePaint,
      );
    if (dc.posLine != PosLine.RIGHT)
      canvas.drawLine(
        Offset(rect.left, heightBorder),
        Offset(rect.center.dx-radius, heightBorder),
        linePaint,
      );

    // Paint internal
    final Paint circlePaint = dc.circle.toPaint()..style = PaintingStyle.fill;
    if (dc.circle.width != 0)
      radius = dc.circle.width;
    canvas.drawCircle(rect.center, radius, circlePaint);
    // Paint External
    canvas.drawCircle(rect.center, radius, linePaint);
  }
}
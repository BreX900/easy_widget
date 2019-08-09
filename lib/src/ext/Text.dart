import 'package:flutter/widgets.dart';


class FittedText extends FittedBox {
  FittedText(String text, {
    TextStyle style,
    StrutStyle strutStyle,
    TextAlign textAlign,
    TextDirection textDirection,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
    BoxFit fit: BoxFit.scaleDown,
    Alignment alignment,
  }) : assert(text != null), super(
    child: Text(text,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    ),
    alignment: alignment??_getTextAlign(textAlign),
    fit: fit,
  );

  static Alignment _getTextAlign(TextAlign textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.end:
        return Alignment.bottomRight;
      default:
        return Alignment.topLeft;
    }
  }
}
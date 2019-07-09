

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';


class PriceView extends Text {
  PriceView(int price, {
    Key key,
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
  }) : super.rich(PriceSpan(price),
    key: key,
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
  );
}

class PriceSpan extends TextSpan {
  const PriceSpan(int price, {
    TextStyle style,
    List<TextSpan> children,
    GestureRecognizer recognizer,
    String semanticsLabel,
  }) : super(
    style: style,
    text: '€ ${price/100}',
    children: children,
    recognizer: recognizer,
    semanticsLabel: semanticsLabel,
  );
}
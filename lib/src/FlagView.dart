import 'package:flutter/material.dart';


class FlagView extends StatelessWidget {
  final Locale locale;
  final String path, format;
  final double size;
  final EdgeInsets padding;
  final Widget child;

  const FlagView({Key key,
    @required this.locale, @required this.path, this.format: 'jpg',
    this.size: 40, this.padding: const EdgeInsets.all(8.0), @required this.child,
  }) :
    assert(child != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          width: size,
          height: size,
          fit: BoxFit.contain,
          image: AssetImage(path+locale.languageCode+"."+format),
          child: child,
        ),
      ),
    );
  }
}
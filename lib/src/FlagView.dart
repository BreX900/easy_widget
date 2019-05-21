import 'package:flutter/material.dart';


typedef Widget WidgetDecorator(Widget widget);


class FlagView extends StatelessWidget {
  final Locale locale;
  final double width;
  final String path, format;

  const FlagView({Key key, @required this.locale, @required this.path, this.format: 'jpg', this.width: 32}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(path+locale.languageCode+"."+format, width: width,);
  }

  static generator(List<Locale> lcs, WidgetDecorator widgetDecorator, {@required String path, String format: 'jpg', double width: 32}) {
    return lcs.map((lc) => widgetDecorator(FlagView(locale: lc, path: path, format: format, width: width,)));
  }
}
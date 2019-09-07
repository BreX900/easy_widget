import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ScaffoldBuild {
  Widget buildAppBar(BuildContext context) => null;
  Widget buildBody(BuildContext context);
  Widget buildBottomBar(BuildContext context) => null;
}

abstract class SliverBuild {
  Widget buildAppBar(BuildContext context) => null;
  List<Widget> buildBody(BuildContext context);
}

mixin ThemeMixin<WidgetType extends StatefulWidget> on State<WidgetType> {
  ThemeData _theme;

  ThemeData get theme {
    assert(_theme != null);
    return _theme;
  }

  ColorScheme get cls => theme.colorScheme;

  TextTheme get tt => theme.textTheme;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return null;
  }
}


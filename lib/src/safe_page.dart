import 'package:flutter/material.dart';


class SafePage extends StatelessWidget {
  final Widget child;

  const SafePage({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxContraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: boxContraints.maxHeight,
              minWidth: boxContraints.minWidth,
              maxWidth: boxContraints.maxWidth
          ),
          child: child,
        ),
      );
    },);
  }
}
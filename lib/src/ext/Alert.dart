import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final Widget icon;
  final Widget text;

  const Alert({Key key, @required this.icon, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconTheme(
            data: theme.iconTheme.copyWith(size: 128),
            child: icon,
          ),
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: theme.textTheme.subtitle,
            child: text,
          ),
        ],
      ),
    );
  }
}

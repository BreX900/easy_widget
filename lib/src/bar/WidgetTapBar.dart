import 'package:flutter/material.dart';


/// Custom implementation for custom [TabBar]
class WidgetTapBar extends StatelessWidget {
  /// The active widget
  final int currentIndex;
  /// The user's tap on the widget
  final ValueChanged<int> onTap;
  /// the widgets displayed
  final List<Widget> children;

  WidgetTapBar({Key key,
    this.currentIndex: 0, @required this.onTap,
    @required this.children,
  }) : assert(onTap != null), assert(children.length >= 2 && children.length <= 5), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(children.length, (index) {
        return Expanded(
          child: InkWell(
            onTap: () => onTap(index),
            child: children[index],
          ),
        );
      }).toList(),
    );
  }
}
import 'package:easy_widget/src/bar/WidgetTapBar.dart';
import 'package:easy_widget/src/decorator/ConnectLineTabIndicator.dart';
import 'package:flutter/material.dart';


/// Color progression for [ProgressTapBar]
class ProgressColor {
  final IconThemeData iconCompleted, iconActive, iconIncomplete;
  final Color backCompleted, backActive, backIncomplete;

  const ProgressColor({
    this.backCompleted: Colors.grey, this.backActive: Colors.white, this.backIncomplete: Colors.transparent,
    this.iconCompleted: const IconThemeData(color: Colors.black),
    this.iconActive:  const IconThemeData(color: Colors.grey),
    this.iconIncomplete:  const IconThemeData(color: Colors.white)
  });
}


/// A Bar that shows the icons in order to simulate a progress through the use
/// of circles and lines that connect the various icons
class ProgressTapBar extends WidgetTapBar {
  /// The color and weight of the horizontal and circle line drawn.
  final BorderSide line;
  /// The color progression in user navigation
  final ProgressColor progressColor;
  /// The current tab in which the user is located
  final int currentIndex;
  /// The user's tap on the widget
  final ValueChanged<int> onTap;
  /// The list of icons
  final List<Widget> icons;

  ProgressTapBar({Key key,
    this.currentIndex: 0, @required this.onTap,
    @required this.icons,
    this.line: const BorderSide(width: 3.0, color: Colors.white),
    this.progressColor: const ProgressColor(),
  }) : assert(onTap != null), assert(icons.length >= 2 && icons.length <= 5), super(
    key: key,
    currentIndex: currentIndex,
    onTap: onTap,
    children: _childrenBuilder(icons, currentIndex, line, progressColor),
  );

  static List<Widget> _childrenBuilder(List<Widget> icons, int currentIndex, BorderSide line, ProgressColor pc) {
    return List.generate(icons.length, (index) {
      final iconTheme = index < currentIndex ? pc.iconCompleted :
        (index == currentIndex ? pc.iconActive : pc.iconIncomplete);
      return Container(
        decoration: ConnectLineTabIndicator(
          line: line,
          circle: BorderSide(
            width: iconTheme.size??24,
            color: index < currentIndex ? pc.backCompleted :
              (index == currentIndex ? pc.backActive : pc.backIncomplete),
          ),
          posLine: index == 0 ? PosLine.RIGHT : (index == icons.length-1 ? PosLine.LEFT : PosLine.BOTH),
        ),
        child: Tab(icon: IconTheme(
          data: iconTheme,
          child: icons[index],
        )),
      );
    }).toList();
  }

  factory ProgressTapBar.number({
    int currentIndex: 0, @required ValueChanged<int> onTap,
    int length: 2,
    BorderSide line: const BorderSide(width: 3.0, color: Colors.white),
    ProgressColor progressColor: const ProgressColor()
  }) {

    final List<Widget> icons = List.generate(length, (index) {
      return Builder(
        builder: (context) {
          final iconTheme = IconTheme.of(context);
          return Text('${index+1}', style: TextStyle(fontSize: iconTheme.size, color: iconTheme.color),);
        },
      );
    }).toList();

    return ProgressTapBar(
      currentIndex:  currentIndex, onTap: onTap,
      icons: icons,
      line: line, progressColor: progressColor,
    );
  }
}
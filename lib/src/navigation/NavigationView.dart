import 'package:easy_widget/src/navigation/DefaultNavigationController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatelessWidget {
  final TabController controller;

  final List<Widget> children;

  final ScrollPhysics physics;

  final DragStartBehavior dragStartBehavior;

  const NavigationView({Key key,
    this.controller,
    this.physics: const NeverScrollableScrollPhysics(),
    this.dragStartBehavior: DragStartBehavior.start,
    this.children,
  }) : assert(children != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = controller??DefaultNavigationController.of(context);
    assert(_controller != null, "Pass a [TabController] or use [DefaultNavigationController]");

    return TabBarView(
      controller: _controller,
      physics: physics,
      dragStartBehavior: dragStartBehavior,
      children: children,
    );
  }
}

import 'package:easy_widget/src/navigation/DefaultNavigationController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatefulWidget {
  final List<Widget> children;

  final ScrollPhysics physics;

  final DragStartBehavior dragStartBehavior;

  const NavigationView({
    Key key,
    this.physics: const NeverScrollableScrollPhysics(),
    this.dragStartBehavior: DragStartBehavior.start,
    this.children,
  })  : assert(children != null),
        super(key: key);

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  NavigationController _controller;

  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController = DefaultNavigationController.of(context);
    assert(newController != null, "Use [DefaultNavigationController]");

    if (_controller == newController) return;

    _controller?.removeListener(_controllerListener);
    _controller = newController;
    _controller.addListener(_controllerListener);
    _currentIndex = _controller.index;
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    super.dispose();
  }

  void _controllerListener() {
    setState(() => _currentIndex = _controller.index);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: widget.children,
    );
  }
}

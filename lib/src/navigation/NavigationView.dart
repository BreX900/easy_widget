import 'package:easy_widget/src/navigation/DefaultNavigationController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatefulWidget {
  final NavigationController controller;
  final List<Widget> children;

  final ScrollPhysics physics;

  final DragStartBehavior dragStartBehavior;

  const NavigationView({
    Key key,
    this.controller,
    this.physics: const NeverScrollableScrollPhysics(),
    this.dragStartBehavior: DragStartBehavior.start,
    @required this.children,
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
    final newController = widget.controller ?? DefaultNavigationController.of(context);
    assert(
        newController != null, "Use [DefaultNavigationController] or pass [NavigationController]");

    if (_controller == newController) return;
    _initController(newController);
  }

  @override
  void didUpdateWidget(NavigationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _initController(widget.controller);
    }
  }

  void _initController(NavigationController newController) {
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

//class SliverNavigationView extends StatefulWidget {
//  final NavigationController controller;
//  final List<Widget> children;
//
//  final ScrollPhysics physics;
//
//  final DragStartBehavior dragStartBehavior;
//
//  const SliverNavigationView({
//    Key key,
//    this.controller,
//    this.physics: const NeverScrollableScrollPhysics(),
//    this.dragStartBehavior: DragStartBehavior.start,
//    @required this.children,
//  })  : assert(children != null),
//        super(key: key);
//
//  @override
//  _SliverNavigationViewState createState() => _SliverNavigationViewState();
//}
//
//class _SliverNavigationViewState extends State<SliverNavigationView> {
//  NavigationController _controller;
//
//  int _currentIndex = 0;
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    final newController = widget.controller ?? DefaultNavigationController.of(context);
//    assert(
//    newController != null, "Use [DefaultNavigationController] or pass [NavigationController]");
//
//    if (_controller == newController) return;
//    _initController(newController);
//  }
//
//  @override
//  void didUpdateWidget(SliverNavigationView oldWidget) {
//    super.didUpdateWidget(oldWidget);
//    if (widget.controller != oldWidget.controller) {
//      _initController(widget.controller);
//    }
//  }
//
//  void _initController(NavigationController newController) {
//    _controller?.removeListener(_controllerListener);
//    _controller = newController;
//    _controller.addListener(_controllerListener);
//    _currentIndex = _controller.index;
//  }
//
//  @override
//  void dispose() {
//    _controller.removeListener(_controllerListener);
//    super.dispose();
//  }
//
//  void _controllerListener() {
//    setState(() => _currentIndex = _controller.index);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    SliverList
//    return IndexedStack(
//      index: _currentIndex,
//      children: widget.children,
//    );
//  }
//}

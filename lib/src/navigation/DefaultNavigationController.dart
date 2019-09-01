import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  int _index;

  NavigationController() : this._index = 0;

  int get index => _index;
  set index(int index) {
    _index = index;
    notifyListeners();
  }
}

class DefaultNavigationController extends StatefulWidget {
  final Widget child;

  const DefaultNavigationController({Key key, @required this.child}) : super(key: key);

  static NavigationController of(BuildContext context) => _DefaultNavigationController.of(context);

  @override
  _DefaultNavigationControllerState createState() => _DefaultNavigationControllerState();
}

class _DefaultNavigationControllerState extends State<DefaultNavigationController> {
  NavigationController _controller;

  @override
  void initState() {
    _controller = NavigationController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DefaultNavigationController(
      child: widget.child,
      controller: _controller,
    );
  }
}

class _DefaultNavigationController extends InheritedWidget {
  final NavigationController controller;

  const _DefaultNavigationController({
    Key key,
    @required Widget child,
    @required this.controller,
  })  : assert(child != null),
        super(key: key, child: child);

  static NavigationController of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_DefaultNavigationController)
            as _DefaultNavigationController)
        .controller;
  }

  @override
  bool updateShouldNotify(_DefaultNavigationController old) {
    return controller != old.controller;
  }
}

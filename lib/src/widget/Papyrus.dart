import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Deprecated for Navigator Widget
@deprecated
class PapyrusController {
  final List<VoidCallback> _listeners = [];
  final List<Widget> _children = [];

  Widget get currentPage => _children.last;
  int get length => _children.length;

  PapyrusController();

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void init(Widget child) {
    if (_children.length == 0)
      _children.add(child);
  }

  void push(Widget child) async {
    _children.add(child);
    _listeners.forEach((listener) => listener());
  }

  void dispose() {
    _listeners.clear();
  }

  Future<void> pop() async {
    if (_children.length > 1) {
      _children.removeLast();
      _listeners.forEach((listener) => listener());
    }
  }

  void _listener(int page) {
    if (_children.length-1 != page) {
      pop();
    }
  }
}

@deprecated
class PapyrusNavigator extends InheritedWidget {
  final PapyrusController controller;

  const PapyrusNavigator({
    Key key,
    @required Widget child,
    @required this.controller,
  }) :
        assert(controller != null),
        assert(child != null),
        super(key: key, child: child);

  static PapyrusController of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        PapyrusNavigator) as PapyrusNavigator).controller;
  }

  static void push(BuildContext context, Widget child) {
    of(context).push(child);
  }

  @override
  bool updateShouldNotify(PapyrusNavigator old) {
    return true;
  }
}

@deprecated
class DefaultPapyrusController extends StatefulWidget {
  final Widget child;

  const DefaultPapyrusController({Key key, this.child}) : super(key: key);

  @override
  _DefaultPapyrusControllerState createState() => _DefaultPapyrusControllerState();
}
@deprecated
class _DefaultPapyrusControllerState extends State<DefaultPapyrusController> {
  PapyrusController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PapyrusController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PapyrusNavigator(
      controller: _controller,
      child: widget.child,
    );
  }
}

@deprecated
class PapyrusView extends StatefulWidget {
  final PapyrusController controller;
  final Widget child;

  PapyrusView({this.controller, @required this.child});

  @override
  _PapyrusViewState createState() => _PapyrusViewState();
}
@deprecated
class _PapyrusViewState extends State<PapyrusView> with TickerProviderStateMixin {
  PapyrusController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller?.removeListener(_listener);
    _controller = widget.controller??PapyrusNavigator.of(context);
    assert(_controller != null);
    _controller.init(widget.child);
    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }


  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _controller.currentPage;
  }
}

@deprecated
class PapyrusBackIconButton extends StatefulWidget {
  final PapyrusController controller;
  final Widget icon;

  const PapyrusBackIconButton({Key key, this.icon: const Icon(Icons.arrow_back), this.controller}) : assert(icon != null), super(key: key);

  @override
  _PapyrusBackIconButtonState createState() => _PapyrusBackIconButtonState();
}
@deprecated
class _PapyrusBackIconButtonState extends State<PapyrusBackIconButton> {
  PapyrusController _controller;
  bool _isEnable;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller?.removeListener(_listener);
    _controller = widget.controller??PapyrusNavigator.of(context);
    _controller.addListener(_listener);
    _check();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }

  void _check() {
    _isEnable = _controller.length > 1;
  }

  void _listener() {
    setState(() {
      _check();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEnable) {
      return Container();
    }
    return IconButton(
      onPressed: () {
        PapyrusNavigator.of(context).pop();
      },
      icon: widget.icon,
    );
  }
}

@deprecated
class PapyrusBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading, title;
  final List<Widget> actions;
  final double titleSpacing;

  const PapyrusBar({Key key,
    this.leading: const PapyrusBackIconButton(),
    this.title, this.titleSpacing: NavigationToolbar.kMiddleSpacing,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: kToolbarHeight),
      child: NavigationToolbar(
        middleSpacing: titleSpacing,
        leading: leading,
        middle: title,
        trailing: actions == null ? null : Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      ),
    );
  }
}

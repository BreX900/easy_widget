import 'package:flutter/material.dart';


/// onTapIndex for [WidgetTapBar] tap
typedef Widget TabBarBuilder(BuildContext context, int currentIndex, ValueChanged<int> onTapIndex);


/// A builder to easily manage the customizations of [WidgetTapBar]
class DefaultTabBarBuilder extends StatefulWidget implements PreferredSizeWidget {
  final TabController controller;
  /// A builder of [WidgetTapBar]
  final TabBarBuilder builder;

  const DefaultTabBarBuilder({Key key,
    this.controller, @required this.builder
  }) : assert(builder != null), super(key: key);
  @override
  _DefaultTabBarBuilderState createState() => _DefaultTabBarBuilderState();

  @override
  final preferredSize = const Size.fromHeight(72.0);
}

class _DefaultTabBarBuilderState extends State<DefaultTabBarBuilder> {
  TabController _controller;
  int position = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_positionListener);
  }

  void _updateController() {
    final newController = widget.controller??DefaultTabController.of(context);
    if (_controller == newController) {
      return;
    }
    if (_controller != null) {
      _controller.removeListener(_positionListener);
    }
    _controller = newController;
    if (_controller != null) {
      _controller.addListener(_positionListener);
      position = _controller.index;
    }
  }

  void _positionListener() {
    setState(() {
      position = _controller.index;
    });
  }

  void _onTapListener(int index) {
    _controller.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: widget.preferredSize.height),
      child: widget.builder(context, position, _onTapListener),
    );
  }
}
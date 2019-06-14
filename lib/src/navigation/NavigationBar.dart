import 'package:easy_widget/src/navigation/DefaultNavigationController.dart';
import 'package:flutter/material.dart';


class NavigationBar extends StatefulWidget {
  final TabController controller;

  final List<BottomNavigationBarItem> items;

  final double elevation;

  final BottomNavigationBarType type;

  final Color backgroundColor;

  final double iconSize;

  final Color selectedItemColor;
  final Color unselectedItemColor;

  final double selectedFontSize;
  final double unselectedFontSize;

  final bool showUnselectedLabels;
  final bool showSelectedLabels;

  const NavigationBar({Key key,
    this.controller,
    @required this.items,
    this.elevation: 8.0,
    this.type,
    this.backgroundColor,
    this.iconSize: 24.0,
    this.selectedItemColor, this.unselectedItemColor,
    this.selectedFontSize: 14.0, this.unselectedFontSize: 12.0, // TODO: Add Sp Transformer
    this.showUnselectedLabels, this.showSelectedLabels: true,
  }) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  TabController _controller;
  int _currentIndex = 0;

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
    final newController = widget.controller??DefaultNavigationController.of(context);
    assert(newController != null, "Pass a [TabController] or use [DefaultNavigationController]");
    if (_controller == newController) {
      return;
    }
    _controller?.removeListener(_positionListener);
    _controller = newController;
    if (_controller != null) {
      _controller.addListener(_positionListener);
      _currentIndex = _controller.index;
    }
  }

  void _positionListener() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }

  void _onTapListener(int index) {
    _controller.index = index;
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTapListener,
      items: widget.items,
      elevation: widget.elevation,
      type: widget.type,
      backgroundColor: widget.backgroundColor,
      iconSize: widget.iconSize,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      selectedFontSize: widget.selectedFontSize,
      unselectedFontSize: widget.unselectedFontSize,
      showSelectedLabels: widget.showSelectedLabels,
      showUnselectedLabels: widget.showUnselectedLabels,
    );
  }
}

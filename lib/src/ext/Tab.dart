import 'package:easy_widget/src/ext/Button.dart';
import 'package:flutter/material.dart';


class TabButton extends StatelessWidget {
  final ButtonShield shield;

  final TabController tabController;

  final int value;

  const TabButton({Key key,
    this.shield: const ButtonShield.empty(), this.tabController, this.value: 1,
  }) : assert(shield != null), assert(value != null && value != 0), super(key: key);

  @override
  Widget build(BuildContext context) {

    return Button(
      shield: shield,
      onPressed: () {
        final tabController = this.tabController??DefaultTabController.of(context);
        assert(tabController != null);
        tabController.index += value;
      },
      child: Text(value > 0 ? "Continua" : "Retrocedi"),
    );
  }
}

class _PrimaryScrollController extends StatefulWidget {
  final double scrollOffset;
  final ValueChanged<double> scrollListener;
  final Widget child;

  const _PrimaryScrollController({Key key,
    @required this.scrollOffset, @required this.scrollListener, @required this.child,
  }) : super(key: key);
  @override
  __PrimaryScrollControllerState createState() => __PrimaryScrollControllerState();
}

class __PrimaryScrollControllerState extends State<_PrimaryScrollController> {
  ScrollController _controller;

  @override
  void initState() {
    _initController();
    super.initState();
  }

  @override
  void didUpdateWidget(_PrimaryScrollController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollOffset != oldWidget.scrollOffset) {
      _controller.dispose();
      _initController();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initController() {
    _controller = ScrollController(initialScrollOffset: widget.scrollOffset)..addListener(_listener);
  }

  void _listener() {
    widget.scrollListener(_controller.position.pixels);
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _controller,
      child: widget.child,
    );
  }
}



class ScrollItem<IndicatorType> {
  final IndicatorType indicator;
  final Widget _view;
  double _scrollOffset;

  ScrollItem(this._view, this.indicator, [this._scrollOffset]);

  Widget get view {
    if (_scrollOffset == null)
      return _view;
    return _PrimaryScrollController(
      scrollOffset: _scrollOffset,
      scrollListener: (scrollOffset) {
        _scrollOffset = scrollOffset;
      },
      child: _view,
    );
  }
}

class ScrollItems<IndicatorType> {
  final List<ScrollItem<IndicatorType>> _items;

  ScrollItems(this._items);

  int get length => _items.length;

  List<Widget> get views => _items.map((item) => item.view).toList();

  List<IndicatorType> get indicators => _items.map((item) => item.indicator).toList();
}

class PageItem extends ScrollItem<BottomNavigationBarItem> {
  PageItem(Widget view, BottomNavigationBarItem indicator, [double scrollOffset])
      : super(view, indicator, scrollOffset);
}

class WidgetItem extends ScrollItem<Widget> {
  WidgetItem(Widget view, Widget indicator, [double scrollOffset])
      : super(view, indicator, scrollOffset);
}
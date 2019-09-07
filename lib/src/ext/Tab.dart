import 'package:easy_widget/src/ext/Button.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final TabController tabController;
  final int value;

  final ButtonDesign buttonDesign;
  final ButtonTextTheme textTheme;
  final Color textColor;
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final FocusNode focusNode;

  const TabButton({
    Key key,
    this.tabController,
    this.value: 1,

    /// Button
    this.buttonDesign: ButtonDesign.raised,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.padding,
    this.shape,
    this.clipBehavior,
    this.focusNode,
  })  : assert(buttonDesign != null),
        assert(value != null && value != 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button.basic(
      buttonDesign: buttonDesign,
      color: color,
      onPressed: () {
        final tabController = this.tabController ?? DefaultTabController.of(context);
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

  const _PrimaryScrollController({
    Key key,
    @required this.scrollOffset,
    @required this.scrollListener,
    @required this.child,
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
    _controller = ScrollController(initialScrollOffset: widget.scrollOffset)
      ..addListener(_listener);
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
    if (_scrollOffset == null) return _view;
    return _PrimaryScrollController(
      scrollOffset: _scrollOffset,
      scrollListener: (scrollOffset) {
        _scrollOffset = scrollOffset;
      },
      child: _view,
    );
  }
}

class PageItem extends ScrollItem<BottomNavigationBarItem> {
  PageItem(Widget view, BottomNavigationBarItem indicator, [double scrollOffset])
      : super(view, indicator, scrollOffset);
}

class WidgetItem extends ScrollItem<Widget> {
  WidgetItem(Widget view, Widget indicator, [double scrollOffset])
      : super(view, indicator, scrollOffset);
}

class ScrollItems<IndicatorType> {
  final int length;
  final List<IndicatorType> indicators;
  final List<Widget> views;

  ScrollItems(
    Map<IndicatorType, Widget> items,
  )   : length = items.length,
        indicators = items.keys.toList(),
        views = items.values.toList();
}
import 'package:easy_widget/src/easy_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';


class RubberConcierge extends StatefulWidget {
  final RubberAnimationController controller;
  final Widget opener, closer;

  const RubberConcierge({Key key,
    this.controller,
    this.opener: const Icon(EasyIcon.up_open),
    this.closer: const Icon(EasyIcon.down_open),
  }) : assert(opener != null), assert(closer != null), super(key: key);

  @override
  _RubberConciergeState createState() => _RubberConciergeState();
}

class _RubberConciergeState extends State<RubberConcierge> {
  RubberAnimationController _controller;
  bool isOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller?.removeListener(_listener);
    _controller = widget.controller??PrimaryRubberController.of(context);
    assert(_controller != null, "RubberAnimationController must not be null");
    _controller.addListener(_listener);
  }

  dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }

  _listener() {
    setState(() {
      isOpen = _controller.value == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isOpen ? _controller.collapse() : _controller.expand();
      },
      icon: isOpen ? widget.closer : widget.opener,
    );
  }
}


class PrimaryRubberController extends InheritedWidget {
  final RubberAnimationController controller;
  PrimaryRubberController({
    Key key,
    @required Widget child,
    @required this.controller,
  }) : assert(child != null), assert(controller != null),
        super(key: key, child: child);

  static RubberAnimationController of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        PrimaryRubberController) as PrimaryRubberController).controller;
  }

  @override
  bool updateShouldNotify(PrimaryRubberController old) {
    return true;
  }
}
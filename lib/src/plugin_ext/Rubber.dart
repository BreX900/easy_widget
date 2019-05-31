import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';


class RubberConcierge extends StatefulWidget {
  final RubberAnimationController controller;
  final Widget opener, closer;

  const RubberConcierge({Key key,
    this.controller,
    this.opener: const Icon(Icons.expand_less),
    this.closer: const Icon(Icons.expand_more),
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
      isOpen = _controller.value >= _controller.upperBound-0.1;
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
import 'package:flutter/material.dart';


class FloatingActionButtonMenu extends StatefulWidget {
  final String tooltip;
  final AnimatedIconData animatedIcon;
  final List<FloatingActionButton> buttons;

  FloatingActionButtonMenu({@required this.tooltip, this.animatedIcon: AnimatedIcons.menu_close,
    @required this.buttons});

  @override
  _FloatingActionButtonMenuState createState() => _FloatingActionButtonMenuState();
}

class _FloatingActionButtonMenuState extends State<FloatingActionButtonMenu>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: widget.tooltip,
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: widget.tooltip,
        child: AnimatedIcon(
          icon: widget.animatedIcon,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int multiplier = widget.buttons.length+1;
    List<Widget> buttons = List<Widget>()
      ..addAll(
          widget.buttons.map((button) {
            multiplier--;
            return Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * multiplier,
                0.0,
              ),
              child: Transform.scale(
                scale: _animateIcon.value,
                //opacity: _animateIcon.value+1~/2,
                child: Container(
                    child: button
                ),
              ),
            );
          })
      )..add(toggle());

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: buttons,
    );
  }
}

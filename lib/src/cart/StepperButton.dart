import 'package:flutter/material.dart';


class StepperButton extends StatelessWidget {
  /// Current value (default = [0.0])
  final Widget child;
  /// The action that must take place when pressing on the various icons
  final VoidCallback onIncrement, onDecrease;
  /// Vertical or horizontal layout (default = [true])
  final Axis direction;
  /// [color] The Widget [Color] (default = [ThemeData.buttonColor])
  /// [backgroundColor] The background Widget [Color] (default = [ColorScheme.secondaryVariant])
  final Color color, backgroundColor;
  /// Icon padding (default = [EdgeInsets.all(8.0)])
  final EdgeInsets padding;
  /// [iconIncrement] The Widget of [onIncrement] (default = [Icons.add])
  /// [iconDecrease] The Widget of [onDecrease] (default = [Icons.remove])
  final Widget iconIncrement, iconDecrease;

  final Widget separator;

  const StepperButton({
    Key key,
    this.child: const Text('0'),
    @required this.onIncrement, @required this.onDecrease,
    this.direction: Axis.horizontal,  this.color, this.backgroundColor,
    this.padding: const EdgeInsets.all(8.0),
    this.iconIncrement: const Icon(Icons.add), this.iconDecrease: const Icon(Icons.remove),
    this.separator,
  }) : assert(child != null), assert(padding != null),
        assert(iconDecrease != null && iconIncrement != null), super(key: key);

  Widget separatorBuild() {
    return Padding(
      padding: direction == Axis.horizontal ? const EdgeInsets.symmetric(horizontal: 4.0) : const EdgeInsets.symmetric(vertical: 4.0),
      child: direction == Axis.horizontal ? Divider(height: 0) : VerticalDivider(
        width: 0.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _color = color??theme.textTheme.button.color;
    final iconData = IconThemeData(
      color: _color,
    );

    final decrease = InkWell(
      onTap: onDecrease,
      child: Padding(
        padding: padding,
        child: IconTheme.merge(
          data: iconData,
          child: iconDecrease,
        ),
      ),
    ), increment = InkWell(
      onTap: onIncrement,
      child: Padding(
        padding: padding,
        child: IconTheme.merge(
          data: iconData,
          child: iconIncrement,
        ),
      ),
    );

    final children = <Widget>[
      direction == Axis.horizontal ? decrease : increment,
      separatorBuild(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DefaultTextStyle(
          style: theme.textTheme.button.copyWith(color: _color),
          child: child,
        ),
      ),
      separatorBuild(),
      direction == Axis.horizontal ? increment : decrease,
    ];

    return Material(
      elevation: 2.0,
      type: MaterialType.canvas,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(4.0),
      color: backgroundColor??theme.colorScheme.secondaryVariant,
      child: Flex(
        mainAxisSize: MainAxisSize.min,
        direction: direction,
        children: children,
      ),
    );
  }
}
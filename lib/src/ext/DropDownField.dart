import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DropDownField<T> extends StatelessWidget {

  final Widget hint;
  final Widget disabledHint;
  final TextStyle style;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final double iconSize;
  final Widget icon;
  final ValueChanged<T> onChanged;
  final List<DropdownMenuItem<T>> items;
  final T value;

  const DropDownField({Key key,
    this.hint, this.disabledHint, this.style, @required this.onChanged, @required this.items,
    this.value, this.iconDisabledColor, this.iconEnabledColor, this.iconSize: 24.0, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: (theme.inputDecorationTheme.contentPadding??const EdgeInsets.all(16.0))
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isDense: true,
          isExpanded: false,
          hint: hint,
          disabledHint: disabledHint,
          style: style,
          iconDisabledColor: iconDisabledColor,
          iconEnabledColor: iconEnabledColor,
          iconSize: iconSize,
          onChanged: onChanged,
          icon: icon,
          value: value,
          items: items,
        ),
      ),
    );
  }
}

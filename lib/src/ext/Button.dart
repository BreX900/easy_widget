import 'package:easy_widget/easy_widget.dart';
import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonShield shield;
  final Widget child;

  const Button({Key key,
    this.onPressed, this.shield: const ButtonShield(), this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (shield.buttonDesign == ButtonDesign.raised) {
      return RaisedButton(
        onPressed: onPressed,
        textTheme: shield.textTheme,
        textColor: shield.textColor,
        disabledTextColor: shield.disabledTextColor,
        color: shield.color,
        disabledColor: shield.disabledColor,
        focusColor: shield.focusColor,
        hoverColor: shield.hoverColor,
        highlightColor: shield.highlightColor,
        splashColor: shield.splashColor,
        padding: shield.padding,
        shape: shield.shape,
        clipBehavior: shield.clipBehavior,
        focusNode: shield.focusNode,
        child: child,
      );
    } else if (shield.buttonDesign == ButtonDesign.flat) {
      return FlatButton(
        onPressed: onPressed,
        textTheme: shield.textTheme,
        textColor: shield.textColor,
        disabledTextColor: shield.disabledTextColor,
        color: shield.color,
        disabledColor: shield.disabledColor,
        focusColor: shield.focusColor,
        hoverColor: shield.hoverColor,
        highlightColor: shield.highlightColor,
        splashColor: shield.splashColor,
        padding: shield.padding,
        shape: shield.shape,
        clipBehavior: shield.clipBehavior,
        focusNode: shield.focusNode,
        child: child,
      );
    }

    throw "Not implement Cupertino design";
  }
}


class ButtonShield {
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

  const ButtonShield({
    this.buttonDesign: ButtonDesign.raised,
    this.textTheme,
    this.textColor, this.disabledTextColor, this.color, this.disabledColor,
    this.focusColor, this.hoverColor, this.highlightColor, this.splashColor,
    this.padding, this.shape, this.clipBehavior,
    this.focusNode,
  }) : assert(buttonDesign != null);

  const ButtonShield.empty({
    this.buttonDesign: ButtonDesign.raised,
    this.textTheme,
    this.textColor, this.disabledTextColor, this.color, this.disabledColor,
    this.focusColor, this.hoverColor, this.highlightColor, this.splashColor,
    this.padding, this.shape, this.clipBehavior,
    this.focusNode,
  }) : assert(buttonDesign != null);

  ButtonShield copyWith({
    ButtonDesign buttonDesign,
    VoidCallback onPressed,
    ButtonTextTheme textTheme,
    Color textColor, Color disabledTextColor, Color color, Color disabledColor,
    Color focusColor, Color hoverColor, Color highlightColor, Color splashColor,
    ShapeBorder shape, Clip clipBehavior,
    FocusNode focusNode,
    Widget child,
  }) {
    return ButtonShield(
      buttonDesign: buttonDesign??this.buttonDesign,
      textTheme: textTheme??this.textTheme,
      textColor: textColor??this.textColor,
      disabledTextColor: disabledTextColor??this.disabledTextColor,
      color: color??this.color,
      disabledColor: disabledColor??this.disabledColor,
      focusColor: focusColor??this.focusColor,
      hoverColor: hoverColor??this.hoverColor,
      highlightColor: highlightColor??this.highlightColor,
      splashColor: splashColor??this.splashColor,
      shape: shape??this.shape,
      clipBehavior: clipBehavior??this.clipBehavior,
      focusNode: focusNode??this.focusNode,
    );
  }

  ButtonShield applyPocket(ButtonShield pocket) {
    return ButtonShield(
      buttonDesign: buttonDesign??pocket.buttonDesign,
      textTheme: textTheme??pocket.textTheme,
      textColor: textColor??pocket.textColor,
      disabledTextColor: disabledTextColor??pocket.disabledTextColor,
      color: color??pocket.color,
      disabledColor: disabledColor??pocket.disabledColor,
      focusColor: focusColor??pocket.focusColor,
      hoverColor: hoverColor??pocket.hoverColor,
      highlightColor: highlightColor??pocket.highlightColor,
      splashColor: splashColor??pocket.splashColor,
      shape: shape??pocket.shape,
      clipBehavior: clipBehavior??pocket.clipBehavior,
      focusNode: focusNode??pocket.focusNode,
    );
  }
}

enum ButtonDesign {
  raised, flat, cupertino,
}
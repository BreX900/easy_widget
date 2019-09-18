import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Button extends StatelessWidget {
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
  final VoidCallback onPressed;
  final Widget child;

  const Button.basic({
    Key key,
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
    this.clipBehavior: Clip.none,
    this.focusNode,
    this.onPressed,
    this.child,
  })  : assert(buttonDesign != null),
        super(key: key);

  const Button.raised({
    Key key,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    ShapeBorder shape,
    Clip clipBehavior: Clip.none,
    FocusNode focusNode,
    VoidCallback onPressed,
    Widget child,
  }) : this.basic(
          buttonDesign: ButtonDesign.raised,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashColor: splashColor,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          onPressed: onPressed,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    if (buttonDesign == ButtonDesign.raised) {
      return RaisedButton(
        onPressed: onPressed,
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: color,
        disabledColor: disabledColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        splashColor: splashColor,
        padding: padding,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        child: child,
      );
    } else if (buttonDesign == ButtonDesign.flat) {
      return FlatButton(
        onPressed: onPressed,
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: color,
        disabledColor: disabledColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        splashColor: splashColor,
        padding: padding,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        child: child,
      );
    }

    throw "Not implement Cupertino design";
  }
}

class ButtonPocket {
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

  const ButtonPocket({
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
  }) : assert(buttonDesign != null);

  const ButtonPocket.empty({
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
  }) : assert(buttonDesign != null);

  ButtonPocket copyWith({
    ButtonDesign buttonDesign,
    VoidCallback onPressed,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    ShapeBorder shape,
    Clip clipBehavior,
    FocusNode focusNode,
    Widget child,
  }) {
    return ButtonPocket(
      buttonDesign: buttonDesign ?? this.buttonDesign,
      textTheme: textTheme ?? this.textTheme,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      color: color ?? this.color,
      disabledColor: disabledColor ?? this.disabledColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      splashColor: splashColor ?? this.splashColor,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      focusNode: focusNode ?? this.focusNode,
    );
  }

  ButtonPocket applyPocket(ButtonPocket pocket) {
    return ButtonPocket(
      buttonDesign: buttonDesign ?? pocket.buttonDesign,
      textTheme: textTheme ?? pocket.textTheme,
      textColor: textColor ?? pocket.textColor,
      disabledTextColor: disabledTextColor ?? pocket.disabledTextColor,
      color: color ?? pocket.color,
      disabledColor: disabledColor ?? pocket.disabledColor,
      focusColor: focusColor ?? pocket.focusColor,
      hoverColor: hoverColor ?? pocket.hoverColor,
      highlightColor: highlightColor ?? pocket.highlightColor,
      splashColor: splashColor ?? pocket.splashColor,
      shape: shape ?? pocket.shape,
      clipBehavior: clipBehavior ?? pocket.clipBehavior,
      focusNode: focusNode ?? pocket.focusNode,
    );
  }
}

enum ButtonDesign {
  raised,
  flat,
  cupertino,
}

class SignButtonIcon extends IconButton {
  SignButtonIcon({
    double iconSize: 24.0,
    EdgeInsets padding: const EdgeInsets.all(8.0),
    Alignment alignment: Alignment.center,
    Color color,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    Color disabledColor,
    FocusNode focusNode,
    String tooltip,
    @required VoidCallback onPressed,
    @required SignIcon icon,
  }) : super(
          iconSize: iconSize,
          padding: padding,
          alignment: alignment,
          color: color,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          disabledColor: disabledColor,
          focusNode: focusNode,
          tooltip: tooltip,
          onPressed: onPressed,
          icon: _signIcon(icon),
        );

  static Widget _signIcon(SignIcon socialIcon) {
    switch (socialIcon) {
      case SignIcon.google:
        return Icon(FontAwesomeIcons.google);
      case SignIcon.facebook:
        return Icon(FontAwesomeIcons.facebook);
      case SignIcon.twitter:
        return Icon(Icons.call);
    }
    return null;
  }
}

enum SignIcon {
  google,
  facebook,
  twitter,
}

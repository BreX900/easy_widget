import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


typedef Widget _FutureButtonBuilder(BuildContext context, onPressed);



class FutureCallBack extends StatefulWidget {
  final AsyncCallback onPressed;
  final _FutureButtonBuilder builder;

  const FutureCallBack({Key key, this.onPressed, this.builder}) : super(key: key);

  FutureCallBack.raisedButton({
    Color color,
    this.onPressed,
    Widget child,
  }) : this.builder = ((_, onPressed) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      child: child,
    );
  });

  FutureCallBack.inkWell({
    Color color,
    this.onPressed,
    Widget child,
  }) : this.builder = ((_, onPressed) {
    return InkWell(
      onTap: onPressed,
      child: child,
    );
  });

  @override
  _FutureCallBackState createState() => _FutureCallBackState();
}

class _FutureCallBackState extends State<FutureCallBack> {
  bool _isInProgress = false;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _isInProgress ? null : () async {
      setState(() {
        _isInProgress = true;
      });
      await widget.onPressed();
      setState(() {
        _isInProgress = false;
      });
    });
  }
}

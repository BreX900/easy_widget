import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef Widget _FutureButtonBuilder(BuildContext context, VoidCallback onPressed);

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

  void _onTap() {
    setState(() => _isInProgress = true);
    widget.onPressed().whenComplete(_onTapComplete);
  }

  void _onTapComplete() {
    if (_isInProgress != null) setState(() => _isInProgress = false);
  }

  @override
  void dispose() {
    _isInProgress = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _isInProgress ? null : _onTap);
  }
}

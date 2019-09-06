import 'package:flutter/widgets.dart';

class NotifierListener extends StatefulWidget {
  final ChangeNotifier notifier;
  final WidgetBuilder builder;

  const NotifierListener({
    Key key,
    @required this.notifier,
    @required this.builder,
  }) : super(key: key);

  @override
  _NotifierListenerState createState() => _NotifierListenerState();
}

class _NotifierListenerState extends State<NotifierListener> {
  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_listener);
  }

  @override
  void didUpdateWidget(NotifierListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.notifier != oldWidget.notifier) {
      oldWidget.notifier.removeListener(_listener);
      widget.notifier.addListener(_listener);
    }
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

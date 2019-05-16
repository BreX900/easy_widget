import 'package:flutter/material.dart';


class LoadIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.report_problem),
      ),
    );
  }
}


Widget streamBuild<V>({
  V initialData,
  @required Stream<V> stream,
  @required AsyncWidgetBuilder<V> builder,
  AsyncWidgetBuilder<V> loadBuilder,
  AsyncWidgetBuilder<V> errorBuilder,
}) {
  return StreamBuilder<V>(
    initialData: initialData,
    stream: stream,
    builder: (context, snap) {
      if (snap.hasError)
        return (errorBuilder??(c, s) => ErrorIndicator())(context, snap);
      if (!snap.hasData)
        return (loadBuilder??((c, s) => LoadIndicator()))(context, snap);
      return builder(context, snap);
    },
  );
}

class StreamBuild<V> extends StatelessWidget {
  final V initialData;
  final Stream<V> stream;
  final AsyncWidgetBuilder<V> builder, loadBuilder, errorBuilder;

  const StreamBuild({Key key, this.initialData, this.stream, this.builder,
    this.loadBuilder, this.errorBuilder
  }) : super(key: key);

  Widget _loadBuilder(BuildContext context, AsyncSnapshot<V> snap) {
    return loadBuilder == null ?  LoadIndicator() : loadBuilder(context, snap);
  }

  Widget _errorBuilder(BuildContext context, AsyncSnapshot<V> snap) {
    return errorBuilder == null ? ErrorIndicator() : errorBuilder(context, snap);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<V>(
      initialData: initialData,
      stream: stream,
      builder: (context, snap) {
        if (snap.hasError) return _errorBuilder(context, snap);
        if (!snap.hasData) return _loadBuilder(context, snap);
        return builder(context, snap);
      },
    );
  }
}




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SafePage extends StatelessWidget {
  final Widget child;

  const SafePage({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxContraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: boxContraints.maxHeight,
                minWidth: boxContraints.minWidth,
                maxWidth: boxContraints.maxWidth
            ),
            child: child,
          ),
        );
      },
    );
  }
}


class EndSafePage extends StatelessWidget {
  final List<Widget> children;

  const EndSafePage({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxContraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: boxContraints.maxHeight,
                minWidth: boxContraints.minWidth,
                maxWidth: boxContraints.maxWidth
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        );
      },
    );
  }
}


class SliverEndSafePage extends StatelessWidget {
  final List<Widget> slivers;
  final List<Widget> children;

  const SliverEndSafePage({Key key,
    @required this.slivers, @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        ...slivers,
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: children,
          ),
        ),
      ],
    );
  }
}











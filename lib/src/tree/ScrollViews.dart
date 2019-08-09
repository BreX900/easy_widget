import 'package:flutter/widgets.dart';


class TreeScrollView extends StatefulWidget {
  final List<StatelessBranch> branches;

  const TreeScrollView({Key key, @required this.branches,
  }) : assert(branches != null), super(key: key);

  @override
  _TreeScrollViewState createState() => _TreeScrollViewState();
}

class _TreeScrollViewState extends State<TreeScrollView> {

  @override
  void initState() {
    super.initState();
    widget.branches.forEach((branch) {
      if (branch is StatefulBranch) {
        branch._tree = this;
      }
      branch.initBranch(context);
    });
  }

  @override
  void dispose() {
    widget.branches.forEach((branch) => branch.disposeBranch(context));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[];

    widget.branches.forEach((branch) => slivers.addAll(branch.buildBranch(context)));

    return CustomScrollView(
      slivers: slivers,
    );
  }
}


abstract class StatelessBranch {
  const StatelessBranch();

  @mustCallSuper
  void initBranch(BuildContext context) {}

  @mustCallSuper
  void disposeBranch(BuildContext context) {}

  List<Widget> buildBranch(BuildContext context);
}


abstract class StatefulBranch extends StatelessBranch {
  _TreeScrollViewState _tree;

  BuildContext get context => _tree.context;

  // ignore: invalid_use_of_protected_member
  void setState(Function function) => _tree.setState(function);
}


mixin BranchMixin on Widget implements StatelessBranch {
  @override
  List<Widget> buildBranch(BuildContext context) {
    return [this];
  }
}

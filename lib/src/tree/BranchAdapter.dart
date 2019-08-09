import 'package:easy_widget/src/tree/ScrollViews.dart';
import 'package:flutter/widgets.dart';


class BranchToBoxAdapter extends StatelessBranch {
  final List<Widget> slivers;

  const BranchToBoxAdapter(this.slivers);

  @override
  List<Widget> buildBranch(BuildContext context) {
    return slivers;
  }
}


class BranchSliverToBoxAdapter extends StatelessBranch {
  final List<Widget> children;

  const BranchSliverToBoxAdapter(this.children);

  @override
  List<Widget> buildBranch(BuildContext context) {
    return children.map((child) => SliverToBoxAdapter(
      child: child,
    )).toList();
  }
}


class SliverToPaddingAdapter extends SliverPadding {
  SliverToPaddingAdapter({
    Key key,
    @required EdgeInsets padding,
    Widget child,
  }) : super(
    padding: padding,
    sliver: SliverToBoxAdapter(
      child: child,
    ),
  );
}


class CustomScrollViewToBranchAdapter extends StatefulWidget {
  final StatelessBranch branch;

  const CustomScrollViewToBranchAdapter({Key key, @required this.branch}) : super(key: key);

  @override
  _CustomScrollViewToBranchAdapterState createState() => _CustomScrollViewToBranchAdapterState();
}

class _CustomScrollViewToBranchAdapterState extends State<CustomScrollViewToBranchAdapter> {

  @override
  void initState() {
    super.initState();
    widget.branch.initBranch(context);
  }

  @override
  void dispose() {
    widget.branch.disposeBranch(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: widget.branch.buildBranch(context),
    );
  }
}

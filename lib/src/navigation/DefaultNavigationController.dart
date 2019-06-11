import 'package:flutter/material.dart';


class _NavigationControllerScope extends InheritedWidget {
  const _NavigationControllerScope({
    Key key,
    this.controller,
    this.enabled,
    Widget child,
  }) : super(key: key, child: child);

  final TabController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_NavigationControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}

/// The [TabController] for descendant widgets that don't specify one
/// explicitly.
///
/// [DefaultNavigationController] is an inherited widget that is used to share a
/// [TabController] with a [TabBar] or a [TabBarView]. It's used when sharing an
/// explicitly created [TabController] isn't convenient because the tab bar
/// widgets are created by a stateless parent widget or by different parent
/// widgets.
///
/// ```dart
/// class MyDemo extends StatelessWidget {
///   final List<Tab> myTabs = <Tab>[
///     Tab(text: 'LEFT'),
///     Tab(text: 'RIGHT'),
///   ];
///
///   @override
///   Widget build(BuildContext context) {
///     return DefaultTabController(
///       length: myTabs.length,
///       child: Scaffold(
///         appBar: AppBar(
///           bottom: TabBar(
///             tabs: myTabs,
///           ),
///         ),
///         body: TabBarView(
///           children: myTabs.map((Tab tab) {
///             return Center(child: Text(tab.text));
///           }).toList(),
///         ),
///       ),
///     );
///   }
/// }
/// ```
class DefaultNavigationController extends StatefulWidget {
  /// Creates a default tab controller for the given [child] widget.
  ///
  /// The [length] argument is typically greater than one.
  ///
  /// The [initialIndex] argument must not be null.
  const DefaultNavigationController({
    Key key,
    @required this.length,
    this.initialIndex = 0,
    @required this.child,
  }) : assert(initialIndex != null),
        super(key: key);

  /// The total number of tabs. Typically greater than one.
  final int length;

  /// The initial index of the selected tab.
  ///
  /// Defaults to zero.
  final int initialIndex;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Scaffold] whose [AppBar] includes a [TabBar].
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage:
  ///
  /// ```dart
  /// TabController controller = DefaultTabBarController.of(context);
  /// ```
  static TabController of(BuildContext context) {
    final _NavigationControllerScope scope = context.inheritFromWidgetOfExactType(_NavigationControllerScope);
    return scope?.controller;
  }

  @override
  _DefaultNavigationControllerState createState() => _DefaultNavigationControllerState();
}

class _DefaultNavigationControllerState extends State<DefaultNavigationController> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: widget.length,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _NavigationControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }
}

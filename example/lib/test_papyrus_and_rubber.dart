import 'package:easy_widget/easy_widget.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MaterialApp(
        color: Colors.red,
        home: Container(
          height: 100,
          color: Colors.green,
        ),
      ),
    );
  }
}

class TestBarScreen extends StatefulWidget {
  @override
  _TestBarScreenState createState() => _TestBarScreenState();
}

class _TestBarScreenState extends State<TestBarScreen> with TickerProviderStateMixin{
  RubberAnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: LayoutBuilder(
          builder: (_context, box) {
            if (_controller == null) {
              _controller = RubberAnimationController(
                vsync: this,
                lowerBoundValue: AnimationControllerValue(pixel: box.maxHeight-box.constrain(Size.fromHeight(kToolbarHeight)).height),
                duration: Duration(milliseconds: 500),
              );
            }

            return PrimaryRubberController(
              controller: _controller,
              // ignore: deprecated_member_use
              child: DefaultPapyrusController(
                child: RubberBottomSheet(
                  animationController: _controller,
                  lowerLayer: Container(),
                  // ignore: deprecated_member_use
                  upperLayer: PapyrusView(
                    child: PaperOne(),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

// ignore: deprecated_member_use
class PaperOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      appBar: PapyrusBar(
        title: RubberConcierge(),
      ),
      body: InkWell(
        // ignore: deprecated_member_use
        onTap: () => PapyrusNavigator.push(context, PaperTwo()),
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class PaperTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      appBar: PapyrusBar(
        title: RubberConcierge(),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}


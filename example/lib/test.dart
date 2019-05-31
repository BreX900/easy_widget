import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MaterialApp(
        color: Colors.red,
        home: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 100,
                color: Colors.red,
              ),
              Expanded(
                child: Navigator(
                  initialRoute: "/",
                  onGenerateRoute: (settings) {
                    print(settings.name);
                    if (settings.name == "/")
                      return MaterialPageRoute(
                        builder: (_) => PaperOne(),
                        settings: settings
                      );

                    return CupertinoPageRoute(
                      builder: (_) => settings.arguments,
                      settings: settings,
                    );
                  },
                ),
              ),
            ],
          ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}


class PaperOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => PaperTwo())),
        child: Container(
          color: Colors.green,
          height: 200,
        ),
      ),
    );
  }
}

class PaperTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
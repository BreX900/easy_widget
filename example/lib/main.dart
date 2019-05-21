import 'package:flutter/material.dart';
import 'package:easy_widget/easy_widget.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestBarScreen(),
    );
  }
}

class TestBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: DefaultTabBarBuilder(
              builder: (_context, currentIndex, onTapIndex) {
                return ProgressTapBar.number(
                  onTap: onTapIndex,
                  currentIndex: currentIndex,
                  length: 5,
                );
              }
          ),
        ),
        body: TabBarView(
          children: List.generate(5, (index) {
            return Container(
              color: index%2 == 0 ? Colors.yellow : Colors.red,
            );
          }),
        ),
        bottomNavigationBar: DefaultTabBarBuilder(
            builder: (_context, currentIndex, onTapIndex) {
              return BottomNavigationBar(
                onTap: onTapIndex,
                currentIndex: currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.access_time),
                    title: Text("CIAO"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.access_time),
                    title: Text("CIAO"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.access_time),
                    title: Text("CIAO"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.access_time),
                    title: Text("CIAO"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.access_time),
                    title: Text("CIAO"),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
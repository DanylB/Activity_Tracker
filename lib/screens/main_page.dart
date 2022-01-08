import 'package:activity_tracker/screens/export.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  var pageIndex = 2;
  var pages = [
    HomePage(),
    ProfilePage(),
  ];
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[widget.pageIndex - 1],
    );
  }
}

import 'package:activity_tracker/widgets/export.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Map Page'),
      ),
      bottomNavigationBar: BuildBottomNavBar(pageIndexPage: 2),
    );
  }
}

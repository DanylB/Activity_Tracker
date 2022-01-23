import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Build 0.7.200',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

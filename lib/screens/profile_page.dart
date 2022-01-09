import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Center(
        child: Text(
          'Build 0.7.000',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    ));
  }
}

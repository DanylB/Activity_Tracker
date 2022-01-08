import 'package:flutter/material.dart';
import 'package:activity_tracker/widgets/export.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    var pageIndex = arg['pageIndex'];
    return Scaffold(
        body: Scaffold(
      body: Center(
        child: Text(
          'Build 0.6.100',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      bottomNavigationBar: BuildBottomNavBar(pageIndexPage: 5),
    ));
  }
}

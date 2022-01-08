import 'package:activity_tracker/widgets/export.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Community Page'),
      ),
      bottomNavigationBar: BuildBottomNavBar(pageIndexPage: 4),
    );
  }
}

import 'package:activity_tracker/widgets/export.dart';
import 'package:flutter/material.dart';

class BarCodePage extends StatelessWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('BarCode Page'),
      ),
      bottomNavigationBar: BuildBottomNavBar(pageIndexPage: 3),
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:developer' as dev;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.transparent,
    //   systemNavigationBarDividerColor: Colors.red,
    //   systemNavigationBarIconBrightness: Brightness.light,
    //   statusBarColor: Colors.transparent,
    // ));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text('sfsdf'),
        ),
      ),
    );
  }
}

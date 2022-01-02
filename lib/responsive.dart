import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget watch;

  const Responsive({
    required Key key,
    required this.mobile,
    required this.watch,
  }) : super(key: key);

  static bool isWatch(BuildContext context) =>
      MediaQuery.of(context).size.width < 320;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width >= 320;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 320) {
          return mobile;
        } else {
          return watch;
        }
      },
    );
  }
}

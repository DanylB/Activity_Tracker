import 'package:flutter/material.dart';
import 'package:activity_tracker/logic/google_login.dart';
import 'package:activity_tracker/logic/get_data_from_google_fit.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class StepCounter extends StatefulWidget {
  const StepCounter({Key? key}) : super(key: key);

  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  final getDataFromGoogleFit = GetDataFromGoogleFit();

  List<Widget> list = [Text('${DateTime.now()}')];

  var step = '';
  var errors = '';

  String start = '';
  // ignore: prefer_typing_uninitialized_variables
  var startTime;
  // ignore: prefer_typing_uninitialized_variables
  var endTime;

  void displayData() async {
    var a = await getDataFromGoogleFit.printData();
    list.add(Text('${DateTime.now()}'));
//
    if (start == '') {
      start = a.toString();
      startTime = DateTime.now();
    }

    if (start != a.toString()) {
      endTime = DateTime.now();
    }

//
    try {
      setState(() {
        // ignore: unnecessary_null_comparison
        if (a.toString() == null) {
          step = 0.toString();
        }
        step = a.toString();
      });
    } catch (e) {
      showError(e);
    }
  }

  void showError(e) {
    try {
      setState(() {
        errors = 'АААААААААААААААААААААААААААААААА -\n ${e.toString()}';
      });
    } catch (e) {
      showError(e);
    }
  }

  Timer timer = Timer.periodic(const Duration(seconds: 10), (timer) {});

  timerFunc() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      displayData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final googleLogin = GoogleSignInProvider();
    // final googlePrintData = GetDataFromGoogleFit();

    return Column(children: [
      Container(
        alignment: Alignment.center,
        width: 200,
        height: 100,
        color: Colors.grey[300],
        child: Text('Steps = $step'),
      ),
      ElevatedButton(
        onPressed: () {
          timerFunc();
          // googlePrintData.printData();
        },
        child: const Text('Refresh (every 10s)'),
      ),
      ElevatedButton(
        onPressed: () async {
          timer.cancel();
        },
        child: const Text('Stop'),
      ),
      Text('Start = $startTime'),
      Text('End = $endTime'),
      Text(errors),
      ElevatedButton(
        onPressed: () {
          // googleLogin.logout();
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
        },
        child: const Text('Log Out'),
      ),
      ElevatedButton(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.reLogin();
        },
        child: const Text('Refresh Token'),
      ),
      const Divider(),
      SingleChildScrollView(
        child: Column(
          children: [...list],
        ),
      ),
    ]);
  }
}

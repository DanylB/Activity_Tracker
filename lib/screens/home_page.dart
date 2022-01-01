import 'dart:async';
import 'dart:ui';
import 'package:activity_tracker/logic/google_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:activity_tracker/logic/get_data_from_google_fit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeW = MediaQuery.of(context).size.width;
    var sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Container(height: sizeH),
          Positioned(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 1,
                      sigmaY: 1,
                    ),
                    child: Container(
                      width: sizeW,
                      height: 150,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0078FF),
                            Color(0xFF4D2DCA),
                            Color(0xFF6119BC),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // top: 60,
                  // left: 20,
                  child: Text(
                    'Activity Tracker',
                    // style: TextStyle(
                    //   color: Colors.white,
                    //   fontSize: 18,
                    //   fontWeight: FontWeight.w800,
                    //   letterSpacing: 0.55,
                    // ),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              width: sizeW,
              height: sizeH,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      StepCounter(),
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
  var startTime;
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
    var e;
    try {
      setState(() {
        errors = 'АААААААААААААААААААААААААААААААА -\n ${e.toString()}';
      });
    } catch (e) {
      showError(e);
    }
  }

  Timer timer = Timer.periodic(Duration(seconds: 10), (timer) {});

  timerFunc() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      displayData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final googleLogin = GoogleSignInProvider();
    final googlePrintData = GetDataFromGoogleFit();

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
        child: Text('Log Out'),
      ),
      ElevatedButton(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.reLogin();
        },
        child: Text('Refresh Token'),
      ),
      Divider(),
      SingleChildScrollView(
        child: Column(
          children: [...list],
        ),
      ),
    ]);
  }
}

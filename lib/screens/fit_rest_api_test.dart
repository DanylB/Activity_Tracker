import 'package:activity_tracker/logic/google_login.dart';
import 'package:activity_tracker/logic/get_data_from_google_fit.dart';
import 'package:flutter/material.dart';

class FitRestApiTest extends StatefulWidget {
  const FitRestApiTest({Key? key}) : super(key: key);

  @override
  State<FitRestApiTest> createState() => _FitRestApiTestState();
}

class _FitRestApiTestState extends State<FitRestApiTest> {
  final getDataFromGoogleFit = GetDataFromGoogleFit();

  void displayData() async {
    var a = await getDataFromGoogleFit.printData();

    setState(() {
      btnText = 'Display Data = ${a.toString()}';
    });
  }

  var btnText = 'Display Data';

  @override
  Widget build(BuildContext context) {
    final googleLogin = GoogleSignInProvider();
    final getDataFromGoogleFit = GetDataFromGoogleFit();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(300, 200)),
            onPressed: () {
              getDataFromGoogleFit.printData();
            },
            child: const Text("HTTP GET"),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //       primary: Colors.purple, minimumSize: const Size(300, 200)),
          //   onPressed: () {
          //     googleLogin.reLogin();
          //   },
          //   child: const Text("ReLogin"),
          // ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.pink[900], minimumSize: const Size(300, 200)),
            onPressed: () {
              // googleLogin.reLogin();
              displayData();
            },
            child: Text(btnText),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, minimumSize: const Size(100, 50)),
            onPressed: () {
              // googleLogin.logout();
              // Navigator.pushNamed(context, '/login_page');
            },
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }
}

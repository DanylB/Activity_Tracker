import 'package:activity_tracker/logic/google_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'export.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          // stream: FirebaseAuth.instance.idTokenChanges(),
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              // return const FitRestApiTest();
              return const HomePage();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('ERROR'),
              );
            } else {
              return Center(
                  child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  // googleLogin.googleLogin();
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                label: const Text('Sign Up with Google'),
                icon: const FaIcon(FontAwesomeIcons.google),
              ));
            }
          }),
    );
  }
}

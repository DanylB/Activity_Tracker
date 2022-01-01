import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:googleapis/fitness/v1.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(
    scopes: <String>[
      'https://www.googleapis.com/auth/fitness.activity.read',
    ],
  );

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      /// Save Access Token in Local Storage
      final accessToken = googleAuth.accessToken;
      var pref = await SharedPreferences.getInstance();
      pref.setString('accessToken', accessToken.toString());
      dev.log('googleLogin = ' + pref.getString('accessToken').toString());
    } catch (e) {
      // reLogin();
      dev.log(e.toString());
    }

    notifyListeners();
  }

  /// Do Silent ReLogin for get update tokens
  Future reLogin() async {
    try {
      var googleUser = await googleSignIn.signInSilently(reAuthenticate: true);

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      /// Save Access Token in Local Storage
      final accessToken = googleAuth.accessToken;
      var pref = await SharedPreferences.getInstance();
      pref.setString('accessToken', accessToken.toString());
      dev.log('reLogin = ' + pref.getString('accessToken').toString());
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

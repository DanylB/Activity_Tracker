import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis/fitness/v1.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLogin {
  //* Initialization GoogleSignIn with the scopes
  final googleSignIn = GoogleSignIn(
    scopes: <String>[
      FitnessApi.fitnessActivityReadScope,
    ],
  );

  //* Class that holds the basic account information of the signed in Google user
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  /// Google LogIn with Firebase
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //* For Refresh Token, credential
    try {
      /// Firebase do login
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      reLogin();
    }

    /// Save Access Token in Local Storage
    final accessToken = googleAuth.accessToken;
    var pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', accessToken.toString());
  }

  /// Do Silent ReLogin for get update tokens
  Future reLogin() async {
    var googleUser = await googleSignIn.signInSilently(reAuthenticate: false);
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    return;
  }

  /// Sign Out
  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

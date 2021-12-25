import 'package:flutter/material.dart';
import 'package:activity_tracker/screens/export.dart';
// import 'package:provider/provider.dart';
// import 'provider/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      initialRoute: '/',
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/home_page': (context) => const HomePage(),
      },
      home: const LoginPage(),
      // home: const HomePage(),
    );
  }
}

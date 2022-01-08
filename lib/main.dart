import 'package:activity_tracker/logic/google_login.dart';
import 'package:flutter/material.dart';
import 'package:activity_tracker/screens/export.dart';
import 'package:provider/provider.dart';
// import 'provider/google_sign_in.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';

import 'model/MyModelStepData.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, // Status Bar bg
      statusBarIconBrightness: Brightness.light, //dark or light Staus bar Icons
      statusBarColor: Colors.transparent, // Status Bar bg Color
      systemNavigationBarColor: Colors.white, // Bottom Nav Bar bg Color
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => MyModelGoogleFitData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        initialRoute: '/',
        routes: {
          '/login_page': (context) => const LoginPage(),
          '/home_page': (context) => const HomePage(),
          '/map_page': (context) => const MapPage(),
          '/bar_code_page': (context) => const BarCodePage(),
          '/community_page': (context) => const CommunityPage(),
          '/profile_page': (context) => const ProfilePage(),
        },
        home: const LoginPage(),
        // home: const HomePage(),
      ),
    );
  }
}

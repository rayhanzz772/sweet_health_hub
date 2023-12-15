import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter_firebase/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/sign_up_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey:
            "AAAAN7qHlrU:APA91bH5mljm2cONJgSQWTvbQS-8WJqMUH1cTWh8FpgjOA2-jlU7UIKCS0t6QC0jin6Sp1RcRW1V-05bq5kVkA_liipfyzCyV1u0WvoGjnogrDyYp7B3Bd-sDmZzzfYnR-WanowS-xrJ",
        appId: "1:239352649397:android:71ea41d41ac6209acc50fc",
        messagingSenderId: "239352649397",
        projectId: "doctornotes-dd168",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => Register(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

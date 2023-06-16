import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//main file
// import 'DashboardScreen.dart';
// import 'ForgetScreen.dart';
// import 'LoginScreen.dart';
import 'RegisterScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: "/register",
      routes: {
        // "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        // "/forget-password": (context) => ForgetScreen(),
        // "/dasboard": (context) => DashBoardScreen(),
      },
    );
  }
}

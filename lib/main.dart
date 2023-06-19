import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'DashboardScreen.dart';
// import 'ForgetScreen.dart';
// import 'LoginScreen.dart';
import 'BillingScreen.dart';
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
      initialRoute: "/billing",
      routes: {
        // "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        // "/forget-password": (context) => ForgetScreen(),
        // "/dasboard": (context) => DashBoardScreen(),
        "/orderstatus": (context) => OrderStatusPage(),
        "/billing": (context) => BillingScreen(products: []),


      },
    );
  }
}

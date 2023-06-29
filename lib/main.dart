import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodkhana/DashBoardScreen.dart';
//import 'package:foodkhana/ForgetScreen.dart';
//import 'package:foodkhana/LoginScreen.dart';
//import 'package:foodkhana/OrderStatusPage.dart';
import 'package:foodkhana/PaymentScreen.dart';

import 'package:foodkhana/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_)=>ProductViewModel())
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ), //m
      initialRoute: "/payment",
      routes: {
        // "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        //"/forget-password": (context) => ForgetScreen(),
        "/dashboard": (context) => DashBoardScreen(),
        //"/orderstatus": (context) => OrderStatusApp(),
        "/payment": (context) => PaymentScreen(totalAmount: 50.0),
        "/billing": (context) => BillingScreen(products: []),
      },
    ),
    );
  }
}

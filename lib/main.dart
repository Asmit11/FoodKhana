import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodkhana/screens/AddToCard.dart';
import 'package:foodkhana/screens/DashBoardScreen.dart';
import 'package:foodkhana/screens/ForgetScreen.dart';
import 'package:foodkhana/screens/LoginScreen.dart';
import 'package:foodkhana/screens/ManagerDashboard.dart';
import 'package:foodkhana/screens/ManagerLoginScreen.dart';
import 'package:foodkhana/screens/OrderStatusPage.dart';
import 'package:foodkhana/screens/Settings.dart';
import 'package:foodkhana/screens/SpecialRequest.dart';
import 'package:foodkhana/screens/StaffLogin.dart';
import 'package:foodkhana/screens/UpdateProduct.dart';
import 'package:foodkhana/screens/UpdateScreen.dart';
import 'package:foodkhana/screens/ViewProfile.dart';
import 'package:foodkhana/services/local_notification_service.dart';
import 'package:foodkhana/viewmodels/auth_viewmodel.dart';
import 'package:foodkhana/viewmodels/global_ui_viewmodel.dart';


import 'package:foodkhana/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';

import 'screens/BillingScreen.dart';
import 'screens/RegisterScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_)=>ProductViewModel()),
        ChangeNotifierProvider(create: (_)=>AuthViewModel()),
        ChangeNotifierProvider(create: (_)=>GlobalUIViewModel())
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ), //m
      initialRoute: "/dashboard",
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/forget-password": (context) => ForgetScreen(),
        "/dashboard": (context) => DashBoardScreen(),
        "/orderstatus": (context) => OrderStatusPage(),
        "/billing": (context) => BillingScreen(),
        "/addtocart": (context) => AddToCart(),
        "/updateproduct": (context)=> UpdateProduct(),
        "/managerdashboard": (context) => ManagerDashboard(),
        "/specialrequest": (context) => SpecialRequest(),
        "/managerlogin": (context) => ManagerLoginScreen(),
        "/viewprofile": (context) => ViewProfile(),
        "/updateprofile": (context) => UpdateScreen(),
        "/settings": (context) => Settings(),
        "/stafflogin": (context)=>StaffLoginScreen(),
      },
    ),
    );
  }
}

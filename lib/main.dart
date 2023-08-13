import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:foodkhana/models/FeedbackModel.dart';
import 'package:foodkhana/screens/AddToCard.dart';
import 'package:foodkhana/screens/CustomerFeedback.dart';
import 'package:foodkhana/screens/DashBoardScreen.dart';
import 'package:foodkhana/screens/EditFeedbackScreen.dart';
import 'package:foodkhana/screens/ForgetScreen.dart';
import 'package:foodkhana/screens/LoginScreen.dart';
import 'package:foodkhana/screens/ManagerDashboard.dart';
import 'package:foodkhana/screens/ManagerLoginScreen.dart';
import 'package:foodkhana/screens/OrderStatusPage.dart';
<<<<<<< HEAD
import 'package:foodkhana/screens/Settings.dart';
import 'package:foodkhana/screens/SpecialRequest.dart';
import 'package:foodkhana/screens/StaffLogin.dart';
import 'package:foodkhana/screens/UpdateProduct.dart';
import 'package:foodkhana/screens/UpdateScreen.dart';
import 'package:foodkhana/screens/ViewProfile.dart';
=======
import 'package:foodkhana/screens/PrintReceiptScreen.dart';
>>>>>>> 36618c88e25aabc977219947477fb18728fcf31c
import 'package:foodkhana/services/local_notification_service.dart';
import 'package:foodkhana/viewmodels/auth_viewmodel.dart';
import 'package:foodkhana/viewmodels/global_ui_viewmodel.dart';
=======
import 'package:foodkhana/BillingScreen.dart';
import 'package:foodkhana/DashBoardScreen.dart';
import 'package:foodkhana/ForgetScreen.dart';
import 'package:foodkhana/LoginScreen.dart';
import 'package:foodkhana/OrderStatusPage.dart';
>>>>>>> d266eb9d0571a7e5f587797b8f123ca40156582a
import 'package:foodkhana/viewmodels/product_viewmodel.dart';
import 'package:foodkhana/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'screens/BillingScreen.dart';
import 'screens/RegisterScreen.dart';
=======

import 'RegisterScreen.dart';

>>>>>>> d266eb9d0571a7e5f587797b8f123ca40156582a
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ), //m
<<<<<<< HEAD
      initialRoute: "/dashboard",
=======
<<<<<<< HEAD
      initialRoute: "/splash",
=======
      initialRoute: "/dashboard",
>>>>>>> d266eb9d0571a7e5f587797b8f123ca40156582a
>>>>>>> 36618c88e25aabc977219947477fb18728fcf31c
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/forget-password": (context) => ForgetScreen(),
        "/dashboard": (context) => DashBoardScreen(),
        "/orderstatus": (context) => OrderStatusPage(),
        "/billing": (context) => BillingScreen(),
<<<<<<< HEAD
        "/addtocart": (context) => AddToCart(),
        "/updateproduct": (context)=> UpdateProduct(),
        "/managerdashboard": (context) => ManagerDashboard(),
<<<<<<< HEAD
        "/specialrequest": (context) => SpecialRequest(),
        "/managerlogin": (context) => ManagerLoginScreen(),
        "/viewprofile": (context) => ViewProfile(),
        "/updateprofile": (context) => UpdateScreen(),
        "/settings": (context) => Settings(),
        "/stafflogin": (context)=>StaffLoginScreen(),
      },
=======
        "/printreceipt": (context) => PrintReceiptScreen(),
        "/feedback": (context) => CustomerFeedback(),
        "/splash": (context)=> SplashScreen(),
        "editfeedback": (context)=> EditFeedbackScreen(),
        },





=======
>>>>>>> d266eb9d0571a7e5f587797b8f123ca40156582a


>>>>>>> 36618c88e25aabc977219947477fb18728fcf31c
    ),
    );
  }
}

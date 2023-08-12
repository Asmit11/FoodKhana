import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodkhana/screens/PaymentScreen.dart';
import 'package:foodkhana/screens/AddToCard.dart';
import 'package:foodkhana/screens/DashBoardScreen.dart';
import 'package:foodkhana/screens/ForgetScreen.dart';
import 'package:foodkhana/screens/LoginScreen.dart';
import 'package:foodkhana/screens/update_password_screen.dart';
import 'package:foodkhana/screens/ManagerDashboard.dart';
import 'package:foodkhana/screens/OrderStatusPage.dart';
import 'package:foodkhana/services/local_notification_service.dart';
import 'package:foodkhana/viewmodels/auth_viewmodel.dart';
import 'package:foodkhana/viewmodels/global_ui_viewmodel.dart';
import 'package:foodkhana/viewmodels/product_viewmodel.dart';
import 'package:foodkhana/screens/edit_order_page.dart'; // Import the EditOrderPage
import 'package:foodkhana/screens/order.dart'; // Import the Order class
import 'package:foodkhana/screens/order_history_page.dart'; // Import the OrderHistoryPage
import 'screens/BillingScreen.dart';
import 'screens/RegisterScreen.dart';

import 'screens/SplitBillScreen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => GlobalUIViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: "/editorder",
        routes: {
          "/login": (context) => LoginScreen(),
          "/register": (context) => RegisterScreen(),
          "/forget-password": (context) => ForgetScreen(),
          "/dashboard": (context) => DashBoardScreen(),
          "/orderstatus": (context) => OrderStatusPage(),
          "/billing": (context) => BillingScreen(),
          "/payment": (context) => PaymentScreen(totalAmount: 50.0),
          "/addtocart": (context) => AddToCart(),
          "/orderhistory": (context) => OrderHistoryPage(),
          "/managerdashboard": (context) => ManagerDashboard(),
          '/split-bill': (context) => SplitBillScreen(splitAmount: 0.0),
          "/updatepassword": (context) => UpdatePasswordScreen(),
          "/editorder": (context) => EditOrderPage(
            order: Order(
              id: '1', // Replace with the actual id
              item: 'Example Item',
              amount: 100.0,
              date: DateTime.now(),
            ),
          ), // Use Order.example() to initialize
        },
      ),
    );
  }
}

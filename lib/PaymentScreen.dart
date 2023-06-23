import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              onPressed: () {
                setState(() {
                  paymentMethod = 'Credit Card';
                });
              },
              child: Text('Credit Card'),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  paymentMethod = 'Cash';
                });
              },
              child: Text('Cash'),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  paymentMethod = 'Mobile Payment';
                });
              },
              child: Text('Mobile Payment'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Selected Payment Method: $paymentMethod',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentScreen(),
  ));
}

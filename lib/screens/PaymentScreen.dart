import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;

  PaymentScreen({required this.totalAmount});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double _amountPaid = 0.0;
  double _changeAmount = 0.0;

  void _calculateChange() {
    setState(() {
      _changeAmount = _amountPaid - widget.totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Amount: \$${widget.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount Paid',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amountPaid = double.tryParse(value) ?? 0.0;
                  _calculateChange();
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Change Amount: \$${_changeAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _amountPaid >= widget.totalAmount ? _completePayment : null,
              child: Text('Complete Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void _completePayment() {
    // Implement payment completion logic here
    // This method will be called when the Complete Payment button is pressed
    // You can integrate with payment gateways or update the payment status in the backend
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Completed'),
          content: Text('Payment of \$${widget.totalAmount.toStringAsFixed(2)} completed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to the next screen or perform any required actions
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant POS'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the PaymentScreen when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentScreen(totalAmount: 50.0),
              ),
            );
          },
          child: Text('Go to Payment'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

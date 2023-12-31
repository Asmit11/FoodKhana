import 'package:flutter/material.dart';
import 'package:foodkhana/models/CartModel.dart';
import 'package:foodkhana/repositories/CardRepository.dart';
import 'package:foodkhana/screens/PrintReceiptScreen.dart';
import 'package:foodkhana/screens/CustomerFeedback.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  List<CartItem> items = [];

  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  Future<void> getCartItems() async {
    final response = await CartRepository().getCart();
    setState(() {
      items = response.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Billing'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/addtocart"); // Navigate back when the back button is pressed
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerFeedback()),
                );
              },
              child: Text("Feedback"),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final e = items[index];
                  return Card(
                    child: ListTile(
                      title: Text(e.product.name.toString()),
                      subtitle: Text(e.product.description.toString()),
                      trailing: Text(e.quantity.toString()),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) {
                int total = 0;
                double total_price = 0;
                items.forEach((element) {
                  total += element.quantity;
                  total_price += (element.product.description ?? 0) * element.quantity; // Corrected calculation using price
                });
                return Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Items: $total"),
                      Text("Total Price: \$${total_price.toStringAsFixed(2)}"),
                      ElevatedButton(
                        onPressed: () {
                          _showTakeawayDialog(); // Call the function to show the alert dialog
                        },
                        child: Icon(Icons.delivery_dining), // Display "Takeaway" on the button
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PrintReceiptScreen()),
                          );
                        },
                        child: Icon(Icons.print),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the alert dialog
  void _showTakeawayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Recorded'),
          content: Text('Your order is recorded as take away.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
//
// class Product {
//   final String name;
//   final double price;
//   final int quantity;
//
//   Product({required this.name, required this.price, required this.quantity});
// }
//
// class BillingScreen extends StatelessWidget {
//   final List<Product> products;
//
//   BillingScreen({required this.products});
//
//   double calculateTotalAmount() {
//     double total = 0;
//     for (var product in products) {
//       total += product.price * product.quantity;
//     }
//     return total;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Billing'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.cabin),
//             onPressed: () {
//               // Handle the Order Status button press
//               showOrderStatusDialog(context);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order Summary',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 4,
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             products[index].name,
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Price: \$${products[index].price.toStringAsFixed(2)} | Quantity: ${products[index].quantity}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             Divider(height: 1, color: Colors.grey),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total Amount:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '\$${calculateTotalAmount().toStringAsFixed(2)}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void showOrderStatusDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Order Status'),
//           content: Text("You'll be trasnfered to order status"),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pushNamed("/orderstatus");
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// void main() {
//   List<Product> products = [
//     Product(name: 'Product 1', price: 10.0, quantity: 2),
//     Product(name: 'Product 2', price: 15.0, quantity: 1),
//     Product(name: 'Product 3', price: 5.0, quantity: 3),
//   ];
//
//   runApp(MaterialApp(
//     title: 'Billing App',
//     home: BillingScreen(products: products),
//   ));
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing'),
        actions: [
          IconButton(
            icon: Icon(Icons.cabin),
            onPressed: () {
              // Handle the Order Status button press
              showOrderStatusDialog(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Product> products = snapshot.data!.docs.map((doc) {
            return Product(
              name: doc['name'],
              price: doc['price'],
              quantity: doc['quantity'],
            );
          }).toList();

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Price: \$${products[index].price.toStringAsFixed(2)} | Quantity: ${products[index].quantity}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Divider(height: 1, color: Colors.grey),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${calculateTotalAmount(products).toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double calculateTotalAmount(List<Product> products) {
    double total = 0;
    for (var product in products) {
      total += product.price * product.quantity;
    }
    return total;
  }

  void showOrderStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Status'),
          content: Text("You'll be transferred to the order status"),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pushNamed("/orderstatus");
              },
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  final int quantity;

  Product({required this.name, required this.price, required this.quantity});
}

void main() {
  runApp(MaterialApp(
    title: 'Billing App',
    home: BillingScreen(),
  ));
}

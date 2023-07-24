import 'package:flutter/material.dart';

class OrderStatusPage extends StatefulWidget {
  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  List<String> orderItems = [
    'Burger',
    'Pizza',
    'Salad',
    'Fries',
  ];

  List<String> orderStatus = [
    'Preparing',
    'Cooking',
    'Ready',
    'Delivered',
  ];

  List<String> orderStatusTime = [
    '10:30 AM',
    '11:00 AM',
    '11:15 AM',
    '11:30 AM',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
      ),
      body: ListView.builder(
        itemCount: orderItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(orderItems[index]),
            subtitle: Text(orderStatus[index]),
            leading: Text(orderStatusTime[index]),
             trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
            IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Product added to cart!'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

          ],
          ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderStatusPage(),
  ));
}

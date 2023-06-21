import 'package:flutter/material.dart';

void main() {
  runApp(OrderStatusApp());
}

class OrderStatusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Status',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderStatusPage(),
    );
  }
}

class OrderStatusPage extends StatefulWidget {
  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  List<Order> orders = [
    Order('Order 1', 'In Progress'),
    Order('Order 2', 'Completed'),
    Order('Order 3', 'Pending'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(orders[index].orderName),
            subtitle: Text(orders[index].status),
          );
        },
      ),
    );
  }
}

class Order {
  final String orderName;
  final String status;

  Order(this.orderName, this.status);
}

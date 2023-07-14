import 'package:flutter/material.dart';

class Order {
  final String id;
  final String item;
  final double amount;
  final DateTime date;

  Order({
    required this.id,
    required this.item,
    required this.amount,
    required this.date,
  });
}

class OrderHistoryPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: '1',
      item: 'Cheeseburger',
      amount: 9.99,
      date: DateTime(2023, 7, 15),
    ),
    Order(
      id: '2',
      item: 'French Fries',
      amount: 4.99,
      date: DateTime(2023, 7, 16),
    ),
    Order(
      id: '3',
      item: 'Pizza',
      amount: 12.99,
      date: DateTime(2023, 7, 17),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (ctx, index) {
          final order = orders[index];
          return ListTile(
            title: Text(order.item),
            subtitle: Text('Amount: \$${order.amount.toStringAsFixed(2)}'),
            trailing: Text(
              order.date.toString(),
              style: TextStyle(fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderHistoryPage(),
  ));
}

import 'package:flutter/material.dart';
import 'order.dart';
import 'edit_order_page.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<Order> orders = [
    // Sample list of orders. Replace this with your actual data.
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
            onTap: () {
              // Navigate to the EditOrderPage to edit the order
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditOrderPage(order: order),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



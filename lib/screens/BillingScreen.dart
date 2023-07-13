import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodkhana/repositories/CardRepository.dart';

import 'package:foodkhana/models/CartModel.dart';

class BillingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Builder(
                builder: (context) {
                  int total = 0;
                  num total_price = 0;
                  items.forEach((element) {
                    total += element.quantity;
                    total_price += (element.product.description
                        ?? 0) * total;
                  });
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Total Items : ${total.toString()}"),
                      ),Container(
                        child: Text("Total Price : ${total_price.toString()}"),
                      ),
                    ],
                  );
                }
            ),
            ...items.map((e) => Container(
              width: double.infinity,
              child: Card(
                child: Column(
                  children: [
                    Text(e.quantity.toString()),
                    Text(e.product.name.toString()),
                    Text(e.product.description.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            CartRepository().removeFromCart(e.product).then((value) {
                              getCartItems();
                            });
                          },
                          child: Icon(Icons.remove),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            CartRepository().addToCart(e.product).then((value) {
                              getCartItems();
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                        ElevatedButton(
                          onPressed: () {

                            CartRepository().removeItemFromCart(e.product).then((value) {
                              getCartItems();
                            });
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
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


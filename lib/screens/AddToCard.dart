
import 'package:flutter/material.dart';
import 'package:foodkhana/models/CartModel.dart';
import 'package:foodkhana/repositories/CardRepository.dart';


class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  List<CartItem> items = [];
  @override
  void initState() {
    // TODO: implement initState
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
      ),
    );
  }
}

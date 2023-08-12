import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  final List<CartItem> items = [];

  void addToCart(Product product) {
    bool itemExists = false;

    for (CartItem item in items) {
      if (item.product.name == product.name) {
        item.quantity++;
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      items.add(CartItem(product: product));
    }
  }

  void removeFromCart(Product product) {
    items.removeWhere((item) => item.product.name == product.name);
  }
}

class AddToCart extends StatelessWidget {
  final Cart cart = Cart();
  final List<Product> products = [
    Product(name: 'Burger', price:250),
    Product(name: 'Momo', price:120),
    Product(name: 'Pizza', price: 800),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.of(context).pushNamed("/dashboard");
        },
          icon: const Icon(Icons.arrow_back),),
        title: Text('Add to Cart'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cart.addToCart(product);
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

                IconButton(
                  icon: Icon(Icons.note_add_outlined),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/specialrequest");
                    // Handle favorite button press
                  },
                ),

                IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.red,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are you sure you want to cancel the order?'),
                          actions: [
                            ElevatedButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),

                            ElevatedButton(
                              child: Text('Yes'),
                              onPressed: () {
                                cart.removeFromCart(product); // Remove the product from the cart
                                Navigator.of(context).pop(); // Close the dialog
                                final snackBar = SnackBar(
                                  content: Text('Your order has been cancelled successfully'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    title: 'Add to Cart',
    home: AddToCart(),
  ));
}

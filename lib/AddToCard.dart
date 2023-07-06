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
}

class AddToCart extends StatelessWidget {
  final Cart cart = Cart();
  final List<Product> products = [
    Product(name: 'Product 1', price: 10.99),
    Product(name: 'Product 2', price: 19.99),
    Product(name: 'Product 3', price: 7.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: IconButton(
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
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Add to Cart',
    home: ProductListScreen(),
  ));
}

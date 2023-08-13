import 'package:flutter/material.dart';
import 'package:foodkhana/models/CartModel.dart';
import 'package:foodkhana/repositories/CardRepository.dart';
import 'package:foodkhana/screens/BillingScreen.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  List<CartItem> items = [];

  @override
  void initState() {
    getCartItems();
    super.initState();
  }
<<<<<<< HEAD

  void removeFromCart(Product product) {
    items.removeWhere((item) => item.product.name == product.name);
  }
}
=======
>>>>>>> 36618c88e25aabc977219947477fb18728fcf31c

  Future<void> getCartItems() async {
    final response = await CartRepository().getCart();
    setState(() {
      items = response.items;
    });
  }


  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add to Cart'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/dashboard");
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  int total = 0;
                  num total_price = 0;
                  items.forEach((element) {
                    total += element.quantity;
                    total_price +=
                        (element.product.description ?? 0) * total;
                  });
                  return Row(
                  );
                },
              ),
              ...items.map(
                    (e) => Container(
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
                                CartRepository()
                                    .removeFromCart(e.product)
                                    .then((value) {
                                  getCartItems();
                                });
                              },
                              child: Icon(Icons.remove),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                CartRepository()
                                    .addToCart(e.product)
                                    .then((value) {
                                  getCartItems();
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                CartRepository()
                                    .removeItemFromCart(e.product)
                                    .then((value) {
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
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillingScreen(),
                    ),
                  );
                },
                child: Icon(Icons.payment),
              ),
            ],
          ),
        ),
>>>>>>> 36618c88e25aabc977219947477fb18728fcf31c
      ),
    );
  }
}
<<<<<<< HEAD



void main() {
  runApp(MaterialApp(
    title: 'Add to Cart',
    home: AddToCart(),
  ));
}
=======
>>>>>>> 36618c88e25aabc977219947477fb18728fcf31c

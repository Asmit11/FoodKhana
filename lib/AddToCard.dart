import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  final String id;
  final String name;
  final double price;

  MenuItem(this.id, this.name, this.price);
}

class ShoppingCartItem {
  final MenuItem menuItem;
  int quantity;

  ShoppingCartItem(this.menuItem, this.quantity);
}

class ShoppingCart {
  List<ShoppingCartItem> items = [];

  void addItem(MenuItem menuItem, int quantity) {
    var existingItemIndex =
    items.indexWhere((item) => item.menuItem.id == menuItem.id);

    if (existingItemIndex != -1) {
      items[existingItemIndex].quantity += quantity;
    } else {
      items.add(ShoppingCartItem(menuItem, quantity));
    }
  }

  void removeItem(MenuItem menuItem) {
    items.removeWhere((item) => item.menuItem.id == menuItem.id);
  }

  void clearCart() {
    items.clear();
  }

  double calculateTotalPrice() {
    double totalPrice = 0;

    for (var item in items) {
      totalPrice += item.menuItem.price * item.quantity;
    }

    return totalPrice;
  }

  void printCart() {
    print('┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓');
    print('┃           Shopping Cart           ┃');
    print('┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫');
    for (var item in items) {
      print(
          '┃ ${item.menuItem.name} - Quantity: ${item.quantity.toString().padLeft(2)} ┃');
    }
    print('┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫');
    print('┃ Total Price: \$${calculateTotalPrice().toStringAsFixed(2).padLeft(7)} ┃');
    print('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛');
  }
}

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Sample menu items
    MenuItem item1 = MenuItem('1', 'Cheeseburger', 10.99);
    MenuItem item2 = MenuItem('2', 'French Fries', 8.99);
    MenuItem item3 = MenuItem('3', 'Soft Drink', 12.99);

    // Create a new shopping cart
    ShoppingCart cart = ShoppingCart();

    // Add items to the shopping cart
    cart.addItem(item1, 2);
    cart.addItem(item2, 1);
    cart.addItem(item3, 3);

    // Print the shopping cart
    cart.printCart();

    // Save the shopping cart to Firestore
    saveCartToFirestore(firestore, cart);
  }

  void saveCartToFirestore(
      FirebaseFirestore firestore, ShoppingCart cart) async {
    // Create a new Firestore collection reference for shopping carts
    CollectionReference cartRef = firestore.collection('carts');

    // Create a new Firestore document reference for the current cart
    DocumentReference docRef = await cartRef.add({});

    // Save each cart item as a subcollection in Firestore
    for (var item in cart.items) {
      await docRef.collection('items').add({
        'menuItemId': item.menuItem.id,
        'quantity': item.quantity,
      });
    }

    print('Shopping cart saved to Firestore with ID: ${docRef.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder widget for the stateful widget
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: AddToCart(),
    ),
  );
}

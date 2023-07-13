import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuItem {
  String name;
  double price;
  bool selected;

  MenuItem({required this.name, required this.price, this.selected = false});
}

class RestaurantPOS extends StatefulWidget {
  @override
  _RestaurantPOSState createState() => _RestaurantPOSState();
}

class _RestaurantPOSState extends State<RestaurantPOS> {
  void _splitBill() {
    // Access the provided list of menu items
    List<MenuItem> menuItems = Provider.of<List<MenuItem>>(context, listen: false);

    // Calculate the total price of all selected menu items
    double totalPrice = menuItems
        .where((item) => item.selected)
        .fold(0, (sum, item) => sum + item.price);

    // Calculate the split amount
    int numberOfPeople = 3; // Replace with the actual number of people
    double splitAmount = totalPrice / numberOfPeople;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SplitBillScreen(splitAmount: splitAmount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant POS'),
      ),
      body: Consumer<List<MenuItem>>(
        builder: (context, menuItems, _) {
          return ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              MenuItem item = menuItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                trailing: Checkbox(
                  value: item.selected,
                  onChanged: (bool? value) {
                    setState(() {
                      item.selected = value ?? false;
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _splitBill,
        child: Icon(Icons.attach_money),
      ),
    );
  }
}

class SplitBillScreen extends StatelessWidget {
  final double splitAmount;

  SplitBillScreen({required this.splitAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Split Bill'),
      ),
      body: Center(
        child: Text(
          'The bill has been split equally.\nEach person owes \$${splitAmount.toStringAsFixed(2)}.',
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<List<MenuItem>>(
          create: (_) => [
            MenuItem(name: 'Burger', price: 9.99),
            MenuItem(name: 'Pizza', price: 12.99),
            MenuItem(name: 'Pasta', price: 8.99),
            MenuItem(name: 'Salad', price: 6.99),
          ],
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant POS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RestaurantPOS(),
    );
  }
}

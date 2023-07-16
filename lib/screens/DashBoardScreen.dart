import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foodkhana/repositories/ProductRepository.dart';
import 'package:foodkhana/screens/AddToCard.dart';
import 'package:foodkhana/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> fetchDataFromViewModel() async {
    try {
      final productViewModel =
      Provider.of<ProductViewModel>(context, listen: false);
      await productViewModel.fetchData();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      fetchDataFromViewModel();
    });
  }

  Widget categoriesContainer({required String image, required String name}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(image)),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        )
      ],
    );
  }
  // void signOut() async {
  //   try {
  //     await _auth.signOut();
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Logged Out")));
  //   } on FirebaseAuthException catch (err) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(err.message.toString()),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }

  Future<void> deleteProduct(String id) async {
    try {
      await ProductRepository().deleteProduct(id);
      fetchDataFromViewModel();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Deleted")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _showDialog(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to delete?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteProduct(id);
            },
            child: Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> addItem() async {
    try {
      final String name = _nameController.text.trim();
      final String description = _descriptionController.text.trim();
      await ProductRepository().addProduct(name, description);
      fetchDataFromViewModel();
      _nameController.clear();
      _descriptionController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Item added successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ProductViewModel>(
        builder: (context, productVM, child) {
          print(productVM.productData);
          return Scaffold(
            drawer: SizedBox(
                height: 739.0,
                child: Drawer(child: ListView(
                  children: [
                    Column(
                      children: [

                        ListTile(
                          title: Text('Account'),
                          leading: Icon(Icons.account_box),
                          onTap:(){
                            Navigator.of(context).pushNamed("/viewprofile");
                          } ,
                        ),

                        ListTile(
                          title: Text('Switch to Manager'),
                          leading: Icon(Icons.switch_account),
                          onTap:(){
                            Navigator.of(context).pushNamed("/managerdashboard");
                          },
                        ),


                        ListTile(
                          title: Text('Order Status'),
                          leading: Icon(Icons.cabin),
                          onTap:(){
                            Navigator.of(context).pushNamed("/orderstatus");
                          },
                        ),

                        ListTile(
                          title: Text('Settings'),
                          leading: Icon(Icons.settings),
                          onTap:(){
                            Navigator.of(context).pushNamed("/settings");

                          } ,
                        ),

                        ListTile(
                          title: Text('Logout'),
                          textColor: Colors.red,
                          leading: Icon(Icons.logout),
                          iconColor: Colors.red,
                          onTap:(){
                            Navigator.of(context).pushNamed("/register");

                          } ,
                        ),
                      ],
                    ),
                  ],
                ),
                )
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),actions:[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddToCart()),
                  );
                },
                child: Icon(Icons.shopping_cart),

              ),
            ],
            ),
            floatingActionButton:FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/dashboard");
                showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        title: Text('Add Item'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                            ),
                            TextField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              addItem();
                            },
                            child: Text('Add'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Color(0xffD64D55),
            ),
            body: Stack(
              children: [
                SizedBox(height: 20),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...productVM.productData.map(
                              (e) =>
                              Card(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(e.data().name.toString()),
                                          Text(e.data().description.toString()),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children:[
                                                IconButton(
                                                  onPressed: (){
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
                                                  icon: Icon(Icons.shopping_cart),
                                                  color: Colors.red,
                                                ),
                                              ]
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    ); }
}

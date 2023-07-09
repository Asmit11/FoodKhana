import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodkhana/repositories/ProductRepository.dart';
import 'package:foodkhana/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({Key? key}) : super(key: key);

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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


  void signOut() async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Logged Out")));
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

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


  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, productVM, child) {
        return Scaffold(
          drawer: SizedBox(
            height: 739.0,
            child: Drawer(
              child: ListView(
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
                        title: Text('Special Request'),
                        leading: Icon(Icons.note_add_outlined),
                        onTap:(){
                          Navigator.of(context).pushNamed("/specialrequest");
                        },
                      ),

                      ListTile(
                        title: Text('Settings'),
                        leading: Icon(Icons.settings),
                        onTap:(){

                        } ,
                      ),

                      ListTile(
                        title: Text('Logout'),
                        textColor: Colors.red,
                        leading: Icon(Icons.logout),
                        iconColor: Colors.red,
                        onTap:(){
                          Navigator.of(context).pushNamed("/register");
                          signOut();
                        } ,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Color(0xffD64D55),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/billing");
              //   showDialog(
              //     context: context,
              //     builder: (context) => AlertDialog(
              //       title: Text('Add Item'),
              //       content: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           TextField(
              //             controller: _nameController,
              //             decoration: InputDecoration(
              //               labelText: 'Name',
              //             ),
              //           ),
              //           TextField(
              //             controller: _descriptionController,
              //             decoration: InputDecoration(
              //               labelText: 'Description',
              //             ),
              //           ),
              //         ],
              //       ),
              //       actions: [
              //         ElevatedButton(
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //             addItem();
              //           },
              //           child: Text('Add'),
              //         ),
              //         ElevatedButton(
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //           child: Text('Cancel'),
              //         ),
              //       ],
              //     ),
              //   );
            },
            child: Icon(Icons.check),
            backgroundColor: Color(0xffD64D55),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      categoriesContainer(
                        image:
                        'https://img.lovepik.com/free-png/20210924/lovepik-burger-png-image_401316034_wh1200.png',
                        name: "Burger",
                      ),
                      categoriesContainer(
                        image:
                        'https://w7.pngwing.com/pngs/56/985/png-transparent-pizza-margherita-sushi-pizza-pizza-delivery-pizza-thumbnail.png',
                        name: "Pizza",
                      ),
                      categoriesContainer(
                        image:
                        'https://img.lovepik.com/element/40144/6472.png_860.png',
                        name: "Momos",
                      ),
                      categoriesContainer(
                        image:
                        'https://cdn.imgbin.com/15/0/25/imgbin-coca-cola-zero-soft-drink-bottle-coca-cola-clear-glass-soda-bottle-8yL3QChxkj3QbKecj7zZZJdRR.jpg',
                        name: "Drinks",
                      ),
                      categoriesContainer(
                        image:
                        'https://img.lovepik.com/free-png/20220120/lovepik-cake-dessert-png-image_401534320_wh860.png',
                        name: "Desserts",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...productVM.productData.map(
                              (e) => Card(
                            child: Column(
                              children: [
                                // Display your product details here
                                // Example: Text(e.name), Text(e.description)

                                Container(
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed("/update-screen");
                                        },
                                        icon: Icon(Icons.edit),
                                        color: Colors.black,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _showDialog(e.id);
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.black,
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
          ),
        );
      },
    );
  }
}
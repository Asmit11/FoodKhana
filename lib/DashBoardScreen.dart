import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodkhana/repositories/ProductRepository.dart';
import 'package:foodkhana/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> fetchDataFromViewmodel() async {
    try {
      final response = await productViewModel.fetchData();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  late ProductViewModel productViewModel;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      productViewModel =
          Provider.of<ProductViewModel>(context, listen: false);
      fetchDataFromViewmodel();
    });
    super.initState();
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
      fetchDataFromViewmodel();
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
          drawer: Drawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD64D55),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/login");
                  signOut();

                  Align(alignment: Alignment.topRight);
                },
                child: Icon(Icons.exit_to_app),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xffD64D55),
                child: Icon(Icons.search, size: 20, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xffD27076),
                  backgroundImage: NetworkImage(
                      'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png'),
                ),
              ),
            ],
            backgroundColor: Color(0xffD64D55),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/add-screen");
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
                // VerticalScroll(),
                SizedBox(height: 20),
                // VerticalScroll(),
                SizedBox(height: 20),
                // VerticalScroll(),
                SizedBox(height: 20),
                // VerticalScroll(),
                SizedBox(height: 20),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        ...productVM.productData.map(
                              (e) => Card(
                            child: Column(
                              children: [
                                Text(e.data().username.toString()),
                                Text(e.data().email.toString()),
                                Text(e.data().address.toString()),
                                Text(e.data().phone.toString()),
                                Text(e.data().gender.toString()),
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
}  //first commit

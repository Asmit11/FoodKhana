// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:foodkhana/models/UserModel.dart';
// import 'package:foodkhana/repositories/AuthRepository.dart';
//
//
// class UpdateProduct extends StatefulWidget {
//   const UpdateProduct({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateProduct> createState() => _UpdateProductScreenState();
// }
//
// class _UpdateProductScreenState extends State<UpdateProduct> {
//   Future<void> updateData() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     DocumentSnapshot document =
//     await firestore.collection('users').doc('mvC4sMMIi1Y6F4aBTFmT').get();
//     try {
//       final data = UserModel(
//         username: _product.text,
//         email: _price.text,
//
//       );
//       //call repo
//       await AuthRepository().updateAuth(id.toString(), data);
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("data saved")));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   TextEditingController _product = TextEditingController(text:'Momo');
//   TextEditingController _price = TextEditingController(text: '150');
//
//
//
//   String? id;
//
//   void fillData(String id) async {
//     try {
//       final response = await AuthRepository().getOneAuth(id);
//       _product.text = response.username.toString();
//       _price.text = response.email.toString();
//
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     DocumentSnapshot document =
//     await firestore.collection('users').doc('user_1').get();
//
//     if (document.exists) {
//       var data = document.data() as Map<String, dynamic>;
//       setState(() {
//         _product.text = data['email'] ?? '';
//         _price.text = data['username'] ?? '';
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _product.dispose();
//     _price.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffD64D55),
//         leading: IconButton(onPressed: () {
//           Navigator.of(context).pushNamed("/managerdashboard");
//         },
//           icon: const Icon(Icons.arrow_back),),
//         title: Text("UpdateProduct"),),
//
//
//       body: SingleChildScrollView(
//         child:
//         Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 8, right: 8),
//               child: TextFormField(
//                 controller: _product,
//                 decoration: InputDecoration(
//                     labelText: 'Product Name'
//                 ),
//               ),
//             ),
//
//             Padding(
//               padding: EdgeInsets.only(left: 8, right: 8),
//               child: TextFormField(
//                 controller: _price,
//                 decoration: InputDecoration(
//                     labelText: 'Price'
//                 ),
//               ),
//             ),
//
//
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(primary: Color(0xffD64D55)),
//                 onPressed: (){
//                   updateData();
//                 } , child:
//             Text("Update"))
//           ],
//         ),
//
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/ProductModel.dart';
import '../repositories/ProductRepository.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  void updateData()async{
    try {
      final data = ProductModel(
          name: _name.text,
          description: double.parse(_price.text)
      );
      //call repo
      await ProductRepository().updateProduct(id.toString(), data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data saved")));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

    }

  }
  TextEditingController _name=TextEditingController();
  TextEditingController _price=TextEditingController();

  String? id;

  void fillData(String id)async{
    try{
      final response = await ProductRepository().getOneProduct(id);
      if(response!=null) {
        _name.text = response.name.toString();
        _price.text = response.description.toString();
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      final args = ModalRoute.of(context)?.settings.arguments;
      if(args!= null){
        setState(() {
          id = args.toString();
        });
        fillData(args.toString());
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (title: Text("update product"),),
      body: Column(
        children: [
          TextFormField(controller: _name,),
          TextFormField(controller: _price,),
          ElevatedButton(onPressed: (){
            updateData();
          }, child: Text("Save"))

        ],
      ),

    );
  }
}


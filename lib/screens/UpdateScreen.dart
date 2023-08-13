import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodkhana/models/UserModel.dart';
import 'package:foodkhana/repositories/AuthRepository.dart';


class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  Future<void> updateData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot document =
    await firestore.collection('users').doc('mvC4sMMIi1Y6F4aBTFmT').get();
    try {
      final data = UserModel(
        username: _username.text,
        email: _email.text,
        
      );
      //call repo
      await AuthRepository().updateAuth(id.toString(), data);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("data saved")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }
  }

  TextEditingController _username = TextEditingController(text:'Aashraya Karki');
  TextEditingController _email = TextEditingController(text: 'Aashrayakarki7@gmail.com');
  TextEditingController _address = TextEditingController(text: 'Lalitpur');
  TextEditingController _phone = TextEditingController(text: '9808750214');
  TextEditingController _gender = TextEditingController(text: 'Male');


  String? id;

  void fillData(String id) async {
    try {
      final response = await AuthRepository().getOneAuth(id);
      _username.text = response.username.toString();
      _email.text = response.email.toString();
      _gender.text = response.phone.toString();
   
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot document =
    await firestore.collection('users').doc('user_1').get();

    if (document.exists) {
      var data = document.data() as Map<String, dynamic>;
      setState(() {
        _email.text = data['email'] ?? '';
        _username.text = data['username'] ?? '';
        _phone.text = data['phone'].toString() ?? '';
        _address.text = data['address'] ?? '';
        _gender = data['gender'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _username.dispose();
    _address.dispose();
    _phone.dispose();
    _email.dispose();
    _gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD64D55),
        leading: IconButton(onPressed: () {
          Navigator.of(context).pushNamed("/viewprofile");
        },
          icon: const Icon(Icons.arrow_back),),
        title: Text("Update Profile"),),


      body: SingleChildScrollView(
        child:
          Column(
            children: [
            Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: TextFormField(
            controller: _username,
            decoration: InputDecoration(
              labelText: 'Full Name'
            ),
          ),
            ),

              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      labelText: 'Email'
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TextFormField(
                  controller: _address,
                  decoration: InputDecoration(
                      labelText: 'Address'
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TextFormField(
                  controller: _phone,
                  decoration: InputDecoration(
                      labelText: 'Phone'
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TextFormField(
                  controller: _gender,
                  decoration: InputDecoration(
                      labelText: 'Gender'
                  ),
                ),
              ),


              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xffD64D55)),
                  onPressed: (){
                updateData();
              } , child:
                  Text("Update"))
            ],
          ),

      ),
    );
  }
}

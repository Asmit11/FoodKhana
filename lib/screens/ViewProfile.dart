import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodkhana/repositories/ProductRepository.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffD64D55),
          leading: IconButton(onPressed: () {
            Navigator.of(context).pushNamed("/dashboard");
          },
            icon: const Icon(Icons.arrow_back),),
          title: Text("Profile"),),

      body: SingleChildScrollView(
            child:
            Column(
                children: [
            Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              initialValue: "Aashraya Karki",
              decoration: InputDecoration(
                  labelText: 'Full Name'
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              initialValue: "Aashrayakarki7@gmail.com",
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              initialValue: "Kalanki",
              decoration: InputDecoration(
                  labelText: 'Address'
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              initialValue: "9808750214",
              decoration: InputDecoration(
                  labelText: 'Phone'
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              initialValue: "Male",
              decoration: InputDecoration(
                  labelText: 'Gender',
              ),
            ),
          ),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color(0xffD64D55)),
                      onPressed: (){
                        Navigator.of(context).pushNamed("/updateprofile");
                      } , child:
                  Text("Update Profile")),
        ],
            ),
        ),
    );
  }
}

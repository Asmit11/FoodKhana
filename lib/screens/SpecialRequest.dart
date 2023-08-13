import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialRequest extends StatefulWidget {
  const SpecialRequest({Key? key}) : super(key: key);

  @override
  State<SpecialRequest> createState() => _SpecialRequestState();
}

class _SpecialRequestState extends State<SpecialRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(onPressed: () {
            Navigator.of(context).pushNamed("/dashboard");
          },
            icon: const Icon(Icons.arrow_back),),
          title: Text("Special Request"),),

      body: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: SingleChildScrollView(
          child:
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Allows for unlimited lines of input
                  decoration: InputDecoration(
                    labelText: ' Enter Request',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 30.0),
                ),
              ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/addtocart");
                      final snackBar = SnackBar(
                        content: Text('Request Added'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } , child:
                Text("Add Request")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

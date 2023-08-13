import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({Key? key}) : super(key: key);

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscureTextPassword = true;

  final _formKey = GlobalKey<FormState>();

  String _uid = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(_auth.currentUser !=null){
        Navigator.of(context).pushNamed("/dasboard");
      }
    });
    super.initState();
  }

  void _login() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Success"))
      );
      Navigator.of(context).pushNamed("/dasboard");

    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('images/Foodkhanalogo.png'),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                    style: const TextStyle(
                        fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureTextPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    style: const TextStyle(
                        fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 22.0,
                        color: Colors.black,
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextPassword = !_obscureTextPassword;
                          });
                        },
                        child: Icon(
                          _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                          size: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/forget-password");
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.red))),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 20)),
                        ),
                        onPressed: () {
                          _login();
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Are you new? Create an account ",
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("/register");
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
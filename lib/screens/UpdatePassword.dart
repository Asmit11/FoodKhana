import 'package:flutter/material.dart';

void main() => runApp(UpdatePasswordApp());

class UpdatePasswordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Password',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpdatePasswordScreen(),
    );
  }
}

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  void _updatePassword() {
    // Perform password update logic here
    // Validate the entered passwords and update the password in the restaurant POS system
    // Show success/error messages to the user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings screen
              // You can replace the below line with your actual navigation logic
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _currentPassword = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _newPassword = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 24.0),
            RaisedButton(
              onPressed: () {
                _updatePassword();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordsMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _currentPasswordController,
              decoration: InputDecoration(labelText: 'Current Password'),
              obscureText: true,
            ),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              onChanged: (_) {
                setState(() {
                  _passwordsMatch =
                      _newPasswordController.text == _confirmPasswordController.text;
                });
              },
            ),
            if (!_passwordsMatch)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Passwords do not match',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                // Call a function to handle password update here
                // You may want to implement a function that communicates with your backend to update the password
                _updatePassword();
              },
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _updatePassword() {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      // Passwords match, update the password logic here
      String newPassword = _newPasswordController.text;
      // Call your API or database update function to update the password
      print('New Password: $newPassword');
      // You may want to show a success message and navigate back to the previous screen after successful update
    } else {
      // Passwords don't match
      setState(() {
        _passwordsMatch = false;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: UpdatePasswordScreen(),
  ));
}

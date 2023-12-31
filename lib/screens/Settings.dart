import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/dashboard");
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("Settings"),
      ),
      body: Center( // Center widget to center the content
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () {
            Navigator.of(context).pushNamed("/forget-password");
          },
          child: Text("Update your password"),
        ),
      ),
    );
  }
}

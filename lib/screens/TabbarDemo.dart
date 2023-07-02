import 'package:flutter/material.dart';

class TabbarDemo extends StatefulWidget {
  const TabbarDemo({Key? key}) : super(key: key);

  @override
  State<TabbarDemo> createState() => _TabbarDemoState();
}

class _TabbarDemoState extends State<TabbarDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Icon(Icons.abc),
              Icon(Icons.usb),
            ],
          )
        ),
        body: TabBarView(
          children: [
            Text("ABC SELECTED"),
            Text("USB SELECTED"),
          ],
        )
      )
    );
  }
}

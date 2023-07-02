import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutDemo extends StatefulWidget {
  const LayoutDemo({Key? key}) : super(key: key);

  @override
  State<LayoutDemo> createState() => _LayoutDemoState();
}

class _LayoutDemoState extends State<LayoutDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.network(
                height: 100,
                  width: 100,
                  "https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
              Container(
                child: Column(
                  children: [
                    Text("Text 1"),
                    Text("Text 2"),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Image.network(
                height: 100,
                  width: 100,
                  "https://www.pngwing.com/en/free-png-avtvu/download"),
              Image.network(
                height: 100,
                  width: 100,
                  "https://www.pngwing.com/en/free-png-avlcg/download"),
              Image.network(
                height: 100,
                  width: 100,
                  "https://www.pngwing.com/en/free-png-vcklz/download"),
            ],
          ),
        ],
      ),
    );
  }
}

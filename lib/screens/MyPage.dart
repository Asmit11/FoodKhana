import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(  // shows the widget down from the notification bar
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ //multiple attribute inside the column uses children
              HeaderWidget(),
              Text("My Name"),
              Text("My description"),
              ButtonWidget(),
              StoryWidget(),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                children: [
                  Image.network("https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                  Image.network("https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                  Image.network("https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                  Image.network("https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                  Image.network("https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png")
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                ),
                Text("My Stories")

              ],
            )
          ),
          Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                  ),
                  Text("My Stories")

                ],
              )
          ),
          Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                  ),
                  Text("My Stories")

                ],
              )
          ),
          Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),
                  ),
                  Text("My Stories")

                ],
              )
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Follow"))),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: (){}, child: Text("Block")),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //to keep the even space between widgets
      children: [
        Container(
          height: 80,
          width: 80,
          child: CircleAvatar(    //widget for circular images
            backgroundImage: NetworkImage(
                "https://download.logo.wine/logo/Instagram/Instagram-Logo.wine.png"),

          ),
        ),
        Column(
          children: [
            Text("20"),
            Text("Post")
          ],
        ),
        Column(
          children: [
            Text("100"),
            Text("Followers")
          ],
        ),
        Column(
          children: [
            Text("200"),
            Text("Following")
          ],
        )

      ],
    );
  }
}

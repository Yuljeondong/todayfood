import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todayfood/model/player.dart';
import 'package:todayfood/screens/page_view.dart';
import 'package:todayfood/screens/settings.dart';

List<String> foods = ['apple', 'banana', 'orange'];
Player user = Player()..pid = 0;
Future<String> food = File("users.json").readAsString();
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Menu!'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),onPressed: null,),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            })),
          )
        ],
      ),
      body: PageScroller(
        foods: foods,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todayfood/model/player.dart';
import 'package:todayfood/screens/login_view.dart';
import 'package:todayfood/screens/page_view.dart';
import 'package:todayfood/services/location.service.dart';

import 'model/location.dart';

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
        home: LoginRoute());
  }
}

class LoginRoute extends StatelessWidget {
  const LoginRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}

class Home extends StatelessWidget {
  const Home({Key key, this.userInfo}) : super(key: key);
  final userInfo;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerModel>(
          create: (context) => PlayerModel(userInfo.pid),
        ),
        // StreamProvider<UserLocation>(
        //   create: (context) => LocationService().locationStream,
        // )
      ],
      child: PageScroller(),
    );
  }
}

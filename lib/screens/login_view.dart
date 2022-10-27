import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:todayfood/main.dart';
import 'package:todayfood/model/player.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Player loginInfo = new Player();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
                // children: <Widget>[
                //   Image.asset('assets/diamond.png'),
                //   SizedBox(height: 16.0),
                //   Text('SHRINE'),
                // ],
                ),
            SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: Text('재입력'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                ElevatedButton(
                  child: Text('로그인'),
                  onPressed: () async {
                    var client = http.Client();
                    var res = await client.post(
                      Uri.http('10.0.2.2:53255', 'api/v1/users/login'),
                      headers: <String, String>{
                        'Content-Type': 'application/x-www-form-urlencoded',
                      },
                      body: <String, String>{
                        'loginId': _usernameController.text,
                        'password': _passwordController.text
                      },
                    );
                    var data = json.decode(res.body);
                    if (data['result']) {
                      loginInfo = Player.fromJson(data);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(userInfo: loginInfo)));
                    } else {
                      AlertDialog(
                        title: new Text(
                          "",
                          textAlign: TextAlign.center,
                        ),
                        content: Container(
                          height: 80,
                          child: Column(
                            children: <Widget>[
                              new Text(
                                '아이디나 비밀번호를 확인해주세요',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        actions: <Widget>[
                          new TextButton(
                            child: new Text("확인"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

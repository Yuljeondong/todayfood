import 'package:flutter/material.dart';
import 'package:todayfood/model/food.dart';
import 'package:todayfood/model/history.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PlayerModel extends ChangeNotifier {
  Player _player;

  List<Food> _recommendList = [];

  void setUserInfo(int id) async {
    var data;
    var res = await http.get(Uri.encodeFull('http://10.0.2.2:53255/api/v1/users/$id'));

    data = json.decode(res.body);
    _player = new Player();
    _player = Player.fromJson(data);
    
    notifyListeners();
  }

  String getName(){
    return _player.name;
  }
  List<History> getHistory(){
    return _player.history;
  }
}

class Player {
  int pid;
  String name;
  List<Food> favorite;
  List<History> history;

  Player();
  // Player(this.pid, this.name, this.recommended, this.history);

  Player.fromJson(Map<String, dynamic> json)
      : pid = int.parse(json['uid']) ,
        name = json['name'],
        favorite = json['favorList'].map<Food>((json) => Food.fromJson(json)).toList(),
        history = json['historyList'].map<History>((json) => History.fromJson(json)).toList();

  
  
  Map<String, dynamic> toJson() => {
        
        'uid': pid,
        'name': name,
        'favorList': favorite,
        'historyList': history,
      };
}

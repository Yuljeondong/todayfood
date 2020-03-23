import 'package:flutter/material.dart';
import 'package:todayfood/model/food.dart';
import 'package:todayfood/model/history.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todayfood/model/youtube.dart';

class PlayerModel extends ChangeNotifier {
  PlayerModel(int id) {
    this.refreshUserInfo(id);
    this.refreshRecommendList();
  }
  Player _player;
  var _youtubeInfo = [YoutubeInfoItem(),YoutubeInfoItem(),YoutubeInfoItem(),];
  List<Food> recommendList = [];

  void refreshUserInfo(int id) async {
    var data;
    var res = await http
        .get(Uri.encodeFull('http://10.0.2.2:53255/api/v1/users/$id'));

    data = json.decode(res.body);
    _player = new Player();
    _player = Player.fromJson(data);
    _player.history.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void refreshRecommendList() async {
    recommendList.clear();
    var data;
    var rest;
    var res =
        await http.get(Uri.encodeFull('http://10.0.2.2:53255/api/v1/food/'));
    data = json.decode(res.body);
    rest = data as List;
    recommendList.clear();
    recommendList
        .addAll(rest.map<Food>((json) => Food.fromJson(json)).toList());
    int i = 0;
    for (var item in recommendList) {
      item.youtubeList = null;
      _youtubeInfo[i].refreshItems(item.name);
      item.youtubeList = _youtubeInfo[i].getItems();
      i++;
    }

    notifyListeners();
  }

  void addHistory(Food food, DateTime date) async {
    _player.history.add(History(food, DateTime.now()));
    _player.history.sort((a, b) => b.date.compareTo(a.date));
    var res = await http.post(Uri.encodeFull(
        'http://10.0.2.2:53255/api/v1/users/${_player.pid}/food/${food.fid}/date/$date'));
  }

  List<Food> getRecommendList() {
    return recommendList;
  }

  String getName() {
    return _player.name;
  }

  List<History> getHistory() {
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
      : pid = int.parse(json['uid']),
        name = json['name'],
        favorite =
            json['favorList'].map<Food>((json) => Food.fromJson(json)).toList(),
        history = json['historyList']
            .map<History>((json) => History.fromJson(json))
            .toList();

  Map<String, dynamic> toJson() => {
        'uid': pid,
        'name': name,
        'favorList': favorite,
        'historyList': history,
      };
}

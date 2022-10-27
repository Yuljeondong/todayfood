// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:todayfood/model/food.dart';
import 'package:todayfood/model/history.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todayfood/model/youtube.dart';

class PlayerModel extends ChangeNotifier {
  PlayerModel(String id) {
    this.refreshUserInfo(id);
    this.refreshRecommendList(id);
  }
  Player _player;
  var _youtubeInfo = [
    YoutubeInfoItem(),
    YoutubeInfoItem(),
    YoutubeInfoItem(),
  ];
  List<Food> recommendList = [];

  void refreshUserInfo(String id) async {
    var client = http.Client();
    var data;
    var res =
        await client.get(Uri.http('10.0.2.2:53255', 'api/v1/users/uid/$id'));

    data = json.decode(res.body);
    _player = new Player();
    _player = Player.fromJson(data);
    _player.history.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void refreshRecommendList(String id) async {
    recommendList.clear();
    var client = http.Client();
    var data;
    var rest;
    var res = await client.post(
      Uri.http('10.0.2.2:53255', 'api/v1/food/cbf'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'uid': id},
    );
    data = json.decode(res.body);
    rest = data as List;
    recommendList.clear();
    recommendList
        .addAll(rest.map<Food>((json) => Food.fromJson(json)).toList());
    // int i = 0;
    // for (var item in recommendList) {
    //   item.youtubeList = null;
    //   _youtubeInfo[i].refreshItems(item.name);
    //   item.youtubeList = _youtubeInfo[i].getItems();
    //   i++;
    // }

    notifyListeners();
  }

  void addHistory(String uid, String fid) async {
    var client = http.Client();
    var res = await client.post(
        Uri.http('10.0.2.2:53255', 'api/v1/history/input'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'uid': uid,
          'fid': fid
        });
    this.refreshUserInfo(uid);
  }

  void removeHistory(History history) async {
    var client = http.Client();
    var res = await client.delete(
      Uri.http('10.0.2.2:53255', 'api/v1/history/rmHist'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'hid': history.hid},
    );
  }

  List<Food> getRecommendList() {
    return recommendList;
  }

  String getName() {
    return _player.name;
  }

  String getPid() {
    return _player.pid;
  }

  List<History> getHistory() {
    if (_player == null) {
      return List<History>.empty();
    }
    return _player.history;
  }
}

class Player {
  String loginId;
  String pid;
  String name;
  List<Food> favorite;
  List<History> history;

  // Player();
  Player([this.loginId, this.pid, this.name, this.favorite, this.history]);

  Player.fromJson(Map<String, dynamic> json)
      : loginId = json['value']['loginId'],
        pid = json['value']['_id'],
        name = json['value']['name'] ?? "",
        favorite = json['value']['favorList'] != null
            ? json['value']['favorList']
                .map<Food>((json) => Food.fromJson(json))
                .toList()
            : [],
        history = json['value']['historyList'] != null
            ? json['value']['historyList']
                .map<History>((json) => History.fromJson(json))
                .toList()
            : [];

  Map<String, dynamic> toJson() => {
        'loginId': loginId,
        'uid': pid,
        'name': name,
        'favorList': favorite,
        'historyList': history,
      };
}

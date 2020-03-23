import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todayfood/config/youtube_config.dart';

class YoutubeInfo {
  String title;
  String description;
  String id;
  String thumbnail;

  YoutubeInfo.fromJson(Map<String, dynamic> json)
      : //hid = json['hid'],
        title = json['snippet']['title'],
        description = json['snippet']['description'],
        thumbnail = json['snippet']['thumbnails']['high']['url'],
        id = json['id']['videoId'];
}

class YoutubeInfoItem {
  final List<YoutubeInfo> _items = [];

  void refreshItems(String food) async {
    _items.clear();
    var data;
    var rest;
    var res = await http.get(Uri.encodeFull(
        'https://www.googleapis.com/youtube/v3/search?key=$youtubeApiKey&part=snippet&q=$food+ 추천&maxResults=3&eventType=completed&safeSearch=moderate&type=video'),headers: {"Accept": "application/json"});

    data = json.decode(res.body);
    rest = data['items'] as List;
    _items.clear();
    _items.addAll(
        rest.map<YoutubeInfo>((json) => YoutubeInfo.fromJson(json)).toList());
  }

  List<YoutubeInfo> getItems() {
    return _items;
  }
}

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:todayfood/model/youtube.dart';

class Food {
  String fid;
  String name;
  String thumbnail;
  // List<String> tag;
  List<YoutubeInfo> youtubeList;
  Food(this.fid, this.name, this.thumbnail);

  Food.fromJson(Map<String, dynamic> json)
      : fid = json['_id'],
        name = json['food_name'],
        thumbnail = json['thumb'];
  // tag = json['food_tags'];
}

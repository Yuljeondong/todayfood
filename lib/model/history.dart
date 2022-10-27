import 'package:todayfood/model/food.dart';

class History {
  String hid;
  Food food;
  DateTime date;

  History(/*this.hid, */ this.food, this.date);

  History.fromJson(Map<String, dynamic> json)
      : hid = json['_id'],
        food = Food.fromJson(json['food']),
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        'hid': hid,
        'fid': food.fid,
        'date': date,
      };
}

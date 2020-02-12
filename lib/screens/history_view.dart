import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todayfood/model/history.dart';
import 'package:todayfood/model/player.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    List<History> history = Provider.of<PlayerModel>(context).getHistory();
    var formatter = DateFormat("yy년 MM월 dd일");
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 0.5,
        title: Text('식사 내역'),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(7),
            child: Container(
              child: ListTile(
                title: Text(formatter.format(history[index].date)),
                subtitle: Text(history[index].food.name),
              ),
            ),
          );
        },
      ),
    );
  }
}

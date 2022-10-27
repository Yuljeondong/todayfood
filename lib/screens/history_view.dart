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
    var player = Provider.of<PlayerModel>(context);
    List<History> history = Provider.of<PlayerModel>(context).getHistory();
    var formatter = DateFormat("yy년 MM월 dd일 HH시 mm분");
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 1.0,
        centerTitle: true,
        title: Text('식사 내역'),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: Key(history[index].hid),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  player.removeHistory(history[index]);
                }
              },
              confirmDismiss: (direction) {
                if (direction == DismissDirection.endToStart) {
                  return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Are you sure?'),
                        content: Text(
                            'Now I am deleting ${history[index].food.name}'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              return Navigator.of(context).pop(false);
                            },
                            child: const Text('CANCEL'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              return Navigator.of(context).pop(true);
                            },
                            child: const Text('DELETE'),
                          ),
                        ],
                      );
                    },
                  );
                }
                return Future.value(false);
              },
              child: Card(
                margin: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    title: Text(formatter.format(history[index].date)),
                    subtitle: Text(history[index].food.name),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

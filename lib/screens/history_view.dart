import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식사 내역'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(7),
            child: Container(
              child: ListTile(
                title: Text('Row $index'),
              ),
            ),
          );
        },
      ),
    );
  }
}

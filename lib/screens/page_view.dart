
import 'package:flutter/material.dart';
import 'package:todayfood/screens/history_view.dart';
import 'package:todayfood/screens/menu_view.dart';

class PageScroller extends StatefulWidget {
  PageScroller({Key key}) : super(key: key);
  PageController _controller;
  @override
  _PageScrollerState createState() => _PageScrollerState();
}

class _PageScrollerState extends State<PageScroller> {
  @override
  void initState() {
    // TODO: implement initState
    widget._controller = PageController(initialPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget._controller,
      children: <Widget>[
        HistoryView(),
        FoodListView(
        )
      ],
    );
  }
}


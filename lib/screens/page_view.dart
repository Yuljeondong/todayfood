
import 'package:flutter/material.dart';
import 'package:todayfood/screens/history_view.dart';
import 'package:todayfood/screens/menu_view.dart';

class PageScroller extends StatefulWidget {
  PageScroller({Key key}) : super(key: key);
  
  @override
  _PageScrollerState createState() => _PageScrollerState();
}

class _PageScrollerState extends State<PageScroller> {
  PageController _controller;
  @override
  
  void initState() {
    _controller = PageController(initialPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: <Widget>[
        HistoryView(),
        FoodListView(
        )
      ],
    );
  }
}


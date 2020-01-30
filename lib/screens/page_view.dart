import 'package:flutter/material.dart';
import 'package:todayfood/screens/calendar.dart';
import 'package:todayfood/screens/menu_view.dart';

class PageScroller extends StatefulWidget {
  PageScroller({Key key, this.foods}) : super(key: key);
  List<String> foods;
  PageController _controller;
  @override
  _PageScrollerState createState() => _PageScrollerState();
}

class _PageScrollerState extends State<PageScroller> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._controller = new PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        controller: widget._controller,
        itemCount: widget.foods.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Calendar();
          }
          return MenuView(food: widget.foods[index-1]);
        },
      ),
    );
  }
}

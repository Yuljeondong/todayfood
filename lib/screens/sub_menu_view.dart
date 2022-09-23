import 'package:flutter/material.dart';
import 'package:todayfood/model/player.dart';
import 'package:provider/provider.dart';

class SubMenuView extends StatelessWidget {
  const SubMenuView({Key key, this.listIndex}) : super(key: key);
  //final subMenu
  final int listIndex;
  @override
  Widget build(BuildContext context) {
    var player = Provider.of<PlayerModel>(context);
    return Card(
        elevation: 10,
        margin: EdgeInsets.all(7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Container(
            height: 300,
            child: Image.network('${player.recommendList[listIndex].thumbnail}')
            // ListTile(
            //   leading: Image.network(
            //     '${player.recommendList[listIndex].thumbnail}',
            //   ),
            //   title: Text(
            //     "고마워케이크by도레도레",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   subtitle: Text("소중해(시그니처), 기분좋아", style: TextStyle(fontSize: 12)),
            //   trailing: Icon(Icons.keyboard_arrow_right),
            // ),
            ));
  }
}

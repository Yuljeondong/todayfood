import 'package:flutter/material.dart';

class SubMenuView extends StatelessWidget {
  const SubMenuView({Key key}) : super(key: key);
  //final subMenu

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        margin: EdgeInsets.all(7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Container(
          height: 75,
          child: ListTile(
            leading: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmsIz9hRe_o6NnMiiLfMLpjJB0KGRpHLHv_ySUjQ5Lb_LYxIxT&s"),
            title: Text(
              "고마워케이크by도레도레",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("소중해(시그니처), 기분좋아", style: TextStyle(fontSize: 12)),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ));
  }
}

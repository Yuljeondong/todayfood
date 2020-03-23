import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todayfood/model/food.dart';
import 'package:todayfood/model/location.dart';
import 'package:todayfood/model/player.dart';
import 'package:todayfood/model/youtube.dart';
import 'package:todayfood/screens/settings.dart';
import 'package:todayfood/screens/sub_menu_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FoodListView extends StatelessWidget {
  const FoodListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var player = Provider.of<PlayerModel>(context);

    //var recommend = player.getRecommendList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        title: Text("오늘의 메뉴"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              player.refreshRecommendList();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            })),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: player.recommendList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                //height: 550,
                child: MenuView(listIndex: index));
          },
        ),
      ),
    );
  }
}

class MenuView extends StatefulWidget {
  MenuView({Key key, this.listIndex}) : super(key: key);
  final int listIndex;
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  
  @override
  void _showDialog(PlayerModel player, Food food, DateTime date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "오늘의 메뉴는",
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                new Text(
                  "${food.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                new Text("\n드시겠어요?", textAlign: TextAlign.center),
              ],
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("결정"),
              onPressed: () {
                player.addHistory(food, date);
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("취소"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var player = Provider.of<PlayerModel>(context);
    //var location = Provider.of<UserLocation>(context);
    return Container(
      child: Card(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          elevation: 7,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              //음식 이름
              Container(
                height: 50,
                padding: EdgeInsets.all(10),
                child: Text(
                  '${player.recommendList[widget.listIndex].name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),

              //유튜브 플레이어
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: player.recommendList[widget.listIndex].youtubeList.length == 0
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                            strokeWidth: 5.0,
                          ),
                        ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: player.recommendList[widget.listIndex].youtubeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return YoutubeTile(food: player.recommendList[widget.listIndex], index: index);
                        },
                      ),
              ),

              //지도
              // Container(
              //   height: 300,
              //   child: Flex(
              //     direction: Axis.vertical,
              //     children: <Widget>[
              //       Text('Map'),
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width -
              //             20, // or use fixed size like 200
              //         height: 284, //ediaQuery.of(context).size.height,
              //         child: GoogleMap(
              //           mapType: MapType.hybrid,
              //           initialCameraPosition: _kGooglePlex,
              //           onMapCreated: (GoogleMapController controller) {
              //             _controller.complete(controller);
              //           },
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              SubMenuView(),

              //메뉴
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ButtonBar(
                  buttonMinWidth: 500,
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        _showDialog(player, player.recommendList[widget.listIndex], DateTime.now());
                        //player.addHistory(widget.food, DateTime.now());
                      },
                      child: Text('메뉴 결정'),
                    )
                  ],
                ),
              )
              //지
            ],
          )),
    );
  }
}

class YoutubeTile extends StatefulWidget {
  YoutubeTile({Key key, this.food, this.index}) : super(key: key);
  final Food food;
  final int index;
  @override
  _YoutubeTileState createState() => _YoutubeTileState();
}

class _YoutubeTileState extends State<YoutubeTile> {
  bool _playerFlag = false;

  togglePlayer() {
    setState(() {
      // _playerFlag = !_playerFlag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          color: Colors.pink[50],
          height: 80,
          child: ListTile(
            leading:
                Image.network(widget.food.youtubeList[widget.index].thumbnail),
            title: Text(
              widget.food.youtubeList[widget.index].title
                  .replaceAll('&#39;', '\'')
                  .replaceAll('&quot;', '\"')
                  .replaceAll('&amp;', '&'),
              maxLines: 2,
              style: TextStyle(fontSize: 14),
            ),
            trailing: IconButton(
                icon: Icon(
                    _playerFlag ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                onPressed: () {
                  _playerFlag = !_playerFlag;
                  togglePlayer();
                }),
          ),
        ),
        _playerFlag
            ? Container(
                width: 300,
                color: Colors.black12,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: YoutubePlayer(
                  controlsTimeOut: Duration(seconds: 10),
                  controller: YoutubePlayerController(
                    initialVideoId: widget.food.youtubeList[widget.index].id,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  //onReady: () {_ycontroller.addListener();},
                ),
              )
            : Container()
      ],
    ));
  }
}

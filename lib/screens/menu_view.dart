import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todayfood/model/player.dart';
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
        title: Text("오늘의 메뉴!"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){player.refreshRecommendList();},
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
          itemCount: player.getRecommendList().length,
          itemBuilder: (BuildContext context, int index) {
            return Container(height: 550, child: MenuView(food: player.getRecommendList()[index].name));
          },
        ),
      ),
    );
  }
}



class MenuView extends StatefulWidget {
  MenuView({Key key, this.food}) : super(key: key);
  final String food;
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

  YoutubePlayerController _ycontroller = YoutubePlayerController(
      initialVideoId: "RT-UHVCcFSA",
      flags: YoutubePlayerFlags(autoPlay: false));
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          elevation: 7,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.all(10),
                child: Text(
                  '${widget.food}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                  height: 207,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      //Text('Video'),
                      YoutubePlayer(
                        controller: _ycontroller,
                        showVideoProgressIndicator: true,
                        //onReady: () {_ycontroller.addListener();},
                      ),
                    ],
                  )),
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
              SubMenuView(),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ButtonBar(
                  buttonMinWidth: 500,
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: null,
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

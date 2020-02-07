import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:todayfood/screens/sub_menu_view.dart';
import 'package:youtube_player/youtube_player.dart';

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
                height: 40,
                padding: EdgeInsets.all(10),
                child: Text(
                  '오늘의 음식은 ${widget.food} 입니다.',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  height: 239,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Text('Video'),
                      YoutubePlayer(
                        context: context,
                        source: "RT-UHVCcFSA",
                        quality: YoutubeQuality.HD,
                        autoPlay: false,
                        showThumbnail: true,
                        // callbackController is (optional).
                        // use it to control player on your own.
                        // callbackController: (controller) {
                        //   _videoController = controller;
                        // },
                      ),
                    ],
                  )),
              Container(
                height: 300,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Text('Map'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          20, // or use fixed size like 200
                      height: 284, //ediaQuery.of(context).size.height,
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SubMenuView(),
              SubMenuView(),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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

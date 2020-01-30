import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:youtube_player/youtube_player.dart';

class MenuView extends StatefulWidget {
  MenuView({Key key, this.food}) : super(key: key);
  String food;
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
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Text(
              '오늘의 음식은 ${widget.food} 입니다.',
            ),
          ),
          Container(
              child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Text('Video'),
              YoutubePlayer(
                context: context,
                source: "1DwmWTtTnb0",
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
          Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Text('Map'),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // or use fixed size like 200
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
          )
          //지
        ],
      ),
    );
  }
}

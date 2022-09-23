import 'dart:async';

import 'package:todayfood/model/location.dart';

class LocationService {
  UserLocation _currentLocation;

  var canChange;

  Future<UserLocation> getLocation() async {
    try {
      // location.changeSettings(interval: 50000);
      // var userLocation = await location.getLocation();
      // // userLocation.time = 5000.0;
      // _currentLocation = UserLocation(
      //   latitude: userLocation.latitude,
      //   longitude: userLocation.longitude,
      // );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}

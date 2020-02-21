import 'dart:async';

import 'package:location/location.dart';
import 'package:todayfood/model/location.dart';

class LocationService {
  UserLocation _currentLocation;

  var canChange;
  var location = Location();

  Future<UserLocation> getLocation() async {
    try {
      location.changeSettings(interval: 50000);
      var userLocation = await location.getLocation();
      // userLocation.time = 5000.0;
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
  
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }
}

//출처: https://sysocoder.com/flutter-%EC%9C%84%EC%B9%98%EC%84%9C%EB%B9%84%EC%8A%A4location-service/
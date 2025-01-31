import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position> get getcurrentPosition async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    late Position currentPosition;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('Location services are Disabled.');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        Future.error('Location permissions are denied.');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      Future.error(
        'Location Permission are permanently denied, we cannot request for permission.',
      );
    }

    currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    return currentPosition;
  }
}

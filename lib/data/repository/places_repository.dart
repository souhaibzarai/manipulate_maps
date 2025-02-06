import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:manipulate_maps/data/models/directions.dart';
import 'package:manipulate_maps/data/models/place_location.dart';

import '../models/place.dart';
import '../webservices/places_web_services.dart';

class PlacesRepository {
  final PlacesWebServices placesWebServices;

  PlacesRepository(this.placesWebServices);

  Future<List<Place>> fetchPlaces(String input, String sessiontoken) async {
    final suggestions =
        await placesWebServices.fetchPlaces(input, sessiontoken);

    final readySuggestions = suggestions.map((suggestion) {
      return Place.fromJson(suggestion);
    }).toList();

    return readySuggestions;
  }

  Future<PlaceLocation> getPlaceLocation(
      String placeID, String sessiontoken) async {
    final place =
        await placesWebServices.getPlaceLocation(placeID, sessiontoken);

    return PlaceLocation.fromJson(place);
  }

  Future<Directions> getDirections(LatLng origin, LatLng destination) async {
    final direction =
        await placesWebServices.getDirections(origin, destination);

    print('directions call is: $direction');

    return Directions.fromJson(direction);
  }
}

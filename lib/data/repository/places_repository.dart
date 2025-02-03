import '../models/place.dart';
import '../webservices/places_web_services.dart';

class PlacesRepository {
  final PlacesWebServices placesWebServices;

  PlacesRepository(this.placesWebServices);

  Future<List<dynamic>> fetchPlaces(String input, String sessiontoken) async {
    final suggestions =
        await placesWebServices.fetchPlaces(input, sessiontoken);

    return suggestions.map((suggestion) {
      return Place.fromJson(suggestion);
    }).toList();
  }
}

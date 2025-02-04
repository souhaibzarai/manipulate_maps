import 'package:dio/dio.dart';
import 'package:manipulate_maps/data/models/place_location.dart';

import '../../constants/strings.dart';

class PlacesWebServices {
  late Dio dio;

  PlacesWebServices() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      receiveTimeout: Duration(seconds: 20),
      connectTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> fetchPlaces(String input, String sessiontoken) async {
    try {
      final response = await dio.get(placesBaseUrl, queryParameters: {
        'input': input,
        'types': 'address',
        'components': 'country:ma',
        'key': googleMapAPIKey,
        'sessiontoken': sessiontoken,
      });
      return response.data['predictions'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeID, String sessiontoken) async {
    try {
      final response = await dio.get(
        placeLocationBaseUrl,
        queryParameters: {
          'place_id': placeID,
          'fields': 'geometry',
          'key': googleMapAPIKey,
          'sessiontoken': sessiontoken,
        },
      );
      return response.data;
    } catch (e) {
      print(e.toString());
      return PlaceLocation.fromJson({});
    }
  }
}

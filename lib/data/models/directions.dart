import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  late List<PointLatLng> polylinePoints;
  late LatLngBounds bounds;
  late String duration;
  late String distance;

  Directions({
    required this.polylinePoints,
    required this.bounds,
    required this.duration,
    required this.distance,
  });

  factory Directions.fromJson(dynamic json) {
    if (json['routes'] == null || (json['routes'] as List).isEmpty) {
      throw Exception("Aucune route trouvée dans la réponse JSON.");
    }

    final data = json['routes'][0];

    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      southwest: LatLng(southwest['lat'], southwest['lng']),
      northeast: LatLng(northeast['lat'], northeast['lng']),
    );

    final leg = (data['legs'] as List).isNotEmpty ? data['legs'][0] : null;

    final String distance = leg['distance']['text'];
    final String duration = leg['duration']['text'];

    if (data['overview_polyline'] == null ||
        data['overview_polyline']['points'] == null) {
      throw Exception("Aucune polyline trouvée.");
    }

    final String polylinePoints = data['overview_polyline']['points'];
    // Vérifier la polyline

    return Directions(
      polylinePoints: PolylinePoints().decodePolyline(polylinePoints),
      bounds: bounds,
      duration: duration,
      distance: distance,
    );
  }
}

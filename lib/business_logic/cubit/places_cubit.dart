import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipulate_maps/data/models/place_location.dart';
import '../../data/models/place.dart';
import '../../data/repository/places_repository.dart';
import 'package:meta/meta.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit(this.placesRepository) : super(PlacesInitial());

  final PlacesRepository placesRepository;

  Future<void> emitAllSuggestions(String input, String sessionToken) async {
    placesRepository.fetchPlaces(input, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  Future<void> emitPlacePosition(String placeID, String sessiontoken) async {
    placesRepository
        .getPlaceLocation(placeID, sessiontoken)
        .then((placeLocation) {
      emit(PlaceLocationLoaded(placeLocation));
    });
  }
}

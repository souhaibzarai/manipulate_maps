import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/places_repository.dart';
import 'package:meta/meta.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit(this.placesRepository) : super(PlacesInitial());

  final PlacesRepository placesRepository;

  Future<void> emitAllSuggestions(String input, String sessionToken) async {
    try {
      final suggestions =
          await placesRepository.fetchPlaces(input, sessionToken);
      emit(PlacesLoaded(suggestions));
    } catch (error) {
      emit(PlacesError(error.toString()));
    }
  }
}

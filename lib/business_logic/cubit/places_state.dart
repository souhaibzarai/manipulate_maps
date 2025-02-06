part of 'places_cubit.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> places;

  PlacesLoaded(this.places);
}

class PlacesError extends PlacesState {
  final String message;

  PlacesError(this.message);
}

class PlaceLocationLoaded extends PlacesState {
  final PlaceLocation placeLocation;

  PlaceLocationLoaded(this.placeLocation);
}

class PlaceLocationError extends PlacesState {
  final String errorMsg;

  PlaceLocationError(this.errorMsg);
}

class PlaceDirectionLoaded extends PlacesState {
  final Directions directions;

  PlaceDirectionLoaded({required this.directions});
}

class PlaceDirectionError extends PlacesState {
  final String errorMsg;

  PlaceDirectionError({required this.errorMsg});
}

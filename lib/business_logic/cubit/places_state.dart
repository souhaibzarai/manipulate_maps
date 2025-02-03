part of 'places_cubit.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<dynamic> places;

  PlacesLoaded(this.places);
}

class PlacesError extends PlacesState {
  final String message;

  PlacesError(this.message);
}

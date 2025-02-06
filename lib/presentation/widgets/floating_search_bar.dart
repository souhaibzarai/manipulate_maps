import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:manipulate_maps/data/models/directions.dart';
import '../../data/models/place.dart';
import 'package:uuid/uuid.dart';

import '../../business_logic/cubit/places_cubit.dart';
import '../../constants/colors.dart';
import 'place_item.dart';

class FloatingSearchBar extends StatefulWidget {
  const FloatingSearchBar({
    super.key,
    required this.onMarkersUpdated,
    required this.position,
    required this.onGetDirection,
  });

  final void Function(Set<Marker>) onMarkersUpdated;

  final Position position;

  final void Function(Set<Polyline>) onGetDirection;

  @override
  State<FloatingSearchBar> createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends State<FloatingSearchBar> {
  Set<Marker> markers = {};
  Set<Marker> emptyMarkers = {};

  Directions? placeDirections; //TODO:
  List<LatLng> polylinePoints = [];
  var isSearchedPlaceMarkerClicked = false;
  var isTimeAndDistanceVisible = false;

  late String duration;
  late String distance;

  late Position markerPositon;

  Set<Marker>? updatedMarkers;

  final FocusNode _focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  List<Place> places = [];
  static const Uuid uuid = Uuid();
  bool isSearchOverlayVisible = false;

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    markerPositon = widget.position;
    super.initState();
  }

  void clearAndCloseSearch() {
    setState(() {
      searchController.clear();
      places.clear();
      isSearchOverlayVisible = false;
      updatedMarkers = {};
    });
    _focusNode.unfocus();
    widget.onMarkersUpdated(emptyMarkers);
  }

  void fetchSuggestions(String query) {
    if (query.isNotEmpty) {
      BlocProvider.of<PlacesCubit>(context)
          .emitAllSuggestions(query, uuid.v4());
    }
  }

  Widget buildSearchBloc() {
    return BlocBuilder<PlacesCubit, PlacesState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = state.places;
          return places.isNotEmpty ? buildPlacesList(places) : buildNoResults();
        } else if (state is PlacesError) {
          return buildErrorMessage(state.message);
        }
        return buildLoadingIndicator();
      },
    );
  }

  Widget buildPlacesList(List<Place> places) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final currentPlace = places[index];
        return PlaceItem(
            suggestion: currentPlace,
            onPlaceItemTap: () async {
              BlocProvider.of<PlacesCubit>(context).emitPlacePosition(
                currentPlace.placeID,
                uuid.v4(),
              );

              setState(() {
                searchController.text = currentPlace.description;
                isSearchOverlayVisible = false;
              });

              _focusNode.unfocus();
            });
      },
    );
  }

  Widget buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          searchController.text.isNotEmpty ? "No results found" : '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget buildErrorMessage(String message) {
    return Center(
      child: Text(
        "Error: $message",
        style: const TextStyle(color: AppColors.errorColor, fontSize: 16),
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return const SizedBox();
  }

  void buildCurrentLocationMarker() {
    setState(() {
      updatedMarkers = updatedMarkers ?? {};
      updatedMarkers!.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: 'My current location'),
          markerId: MarkerId('current_location'),
          position: LatLng(
            markerPositon.latitude,
            markerPositon.longitude,
          ),
        ),
      );
    });

    widget.onMarkersUpdated(updatedMarkers!);

    BlocListener<PlacesCubit, PlacesState>(
      listenWhen: (prev, current) => prev != current,
      listener: (context, state) {
        if (state is PlaceDirectionLoaded) {
          placeDirections = state.directions;

          polylinePoints = placeDirections!.polylinePoints.map((point) {
            return LatLng(point.latitude, point.longitude);
          }).toList();
        }
      },
    );
  }

  void getDirections(LatLng destination) {
    LatLng origin = LatLng(
      markerPositon.latitude,
      markerPositon.longitude,
    );

    BlocProvider.of<PlacesCubit>(context).emitPlaceDirections(
      origin,
      destination,
    );
  }

  Widget buildPlaceLocationBloc({required Widget child}) {
    return BlocListener<PlacesCubit, PlacesState>(
      listenWhen: (prev, current) => prev != current,
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          final lat = state.placeLocation.result.geometry.location.lat;
          final lng = state.placeLocation.result.geometry.location.lng;
          updatedMarkers = {
            Marker(
              markerId: MarkerId('$lat $lng'),
              infoWindow: InfoWindow(title: searchController.value.text),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              position: LatLng(lat, lng),
              onTap: () {
                buildCurrentLocationMarker();
                widget.onGetDirection(
                  {
                    Polyline(
                      polylineId: PolylineId('direction_polyline'),
                      width: 5,
                      color: AppColors.activeColor,
                      points: polylinePoints,
                    ),
                  },
                );
                isSearchedPlaceMarkerClicked = isTimeAndDistanceVisible = true;
              },
            ),
          };
          widget.onMarkersUpdated(updatedMarkers!);

          getDirections(LatLng(lat, lng));
        }
      },
      child: child,
    );
  }

  void removeAllMarkersAndUpdateUi() {
    setState(() {
      isSearchOverlayVisible = true;
      updatedMarkers = {};
    });
    widget.onMarkersUpdated(emptyMarkers);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
        setState(() {
          isSearchedPlaceMarkerClicked = isTimeAndDistanceVisible = false;
        });
      },
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.thirdColor.withAlpha(180),
                  child: buildPlaceLocationBloc(
                    child: TextField(
                      controller: searchController,
                      focusNode: _focusNode,
                      onChanged: fetchSuggestions,
                      onTap: removeAllMarkersAndUpdateUi,
                      decoration: InputDecoration(
                        hintText: 'Search for a location...',
                        hintStyle: TextStyle(color: AppColors.darkColor),
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: AppColors.secondaryColor,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        suffixIcon: IconButton(
                          style: ButtonStyle(
                              iconColor:
                                  WidgetStatePropertyAll(AppColors.darkColor)),
                          hoverColor: AppColors.transparentColor,
                          focusColor: AppColors.transparentColor,
                          onPressed: searchController.text.isNotEmpty ||
                                  isSearchOverlayVisible
                              ? clearAndCloseSearch
                              : null,
                          icon: Icon(
                            searchController.text.isNotEmpty ||
                                    isSearchOverlayVisible
                                ? Icons.clear
                                : Icons.search,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                if (isSearchOverlayVisible)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    constraints: BoxConstraints(
                      maxHeight: size.height * 0.4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.transparentColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: buildSearchBloc(),
                    ),
                  ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}

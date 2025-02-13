import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/colors.dart';
import '../../helpers/location_helper.dart';
import '../widgets/custom_drawer.dart';

import '../widgets/floating_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: AppColors.transparentColor,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColors.darkColor),
      ),
    ),
  );

  showDialog(
    barrierColor: AppColors.thirdColor,
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

class _MapScreenState extends State<MapScreen> {
  static Position? location;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late Set<Polyline> _polylines = {};

  Set<Marker> _markers = {};
  void _updateMarkers(Set<Marker> newMarkers) {
    setState(() {
      _markers = newMarkers;
    });

    if (newMarkers.isNotEmpty) {
      final marker = newMarkers.first;
      _controller.future.then((GoogleMapController controller) {
        controller.animateCamera(CameraUpdate.newLatLng(marker.position));
      });
    }
  }

  void _updatePolyline(Set<Polyline> newPolylines) {
    setState(() {
      _polylines = newPolylines;
    });
  }

  Widget buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: myLocationCameraPosition,
      mapType: MapType.normal,
      buildingsEnabled: true,
      myLocationEnabled: true,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: _markers,
      polylines: _polylines,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Widget buildFloatingActionButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 30),
      child: FloatingActionButton(
        backgroundColor: AppColors.mainColor.withAlpha(160),
        onPressed: goToMyCurrentPositionAndClearUi,
        child: const Icon(
          Icons.place,
          color: AppColors.thirdColor,
        ),
      ),
    );
  }

  Future<void> goToMyCurrentPositionAndClearUi() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(myLocationCameraPosition),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    _controller.future.then(
      (controller) => controller.dispose(),
    );
    super.dispose();
  }

  Future<void> getCurrentLocation() async {
    location = await LocationHelper.getcurrentPosition.whenComplete(() {
      setState(() {});
    });
  }

  CameraPosition get myLocationCameraPosition {
    return CameraPosition(
      target: location != null
          ? LatLng(location!.latitude, location!.longitude)
          : const LatLng(0, 0), // Eviter le crash
      zoom: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            location != null
                ? buildGoogleMap()
                : const Center(child: CircularProgressIndicator()),
            location != null
                ? FloatingSearchBar(
                    onMarkersUpdated: _updateMarkers,
                    position: location!,
                    onGetDirection: _updatePolyline,
                  )
                : const SizedBox(),
          ],
        ),
        floatingActionButton:
            location != null ? buildFloatingActionButton() : null,
      ),
    );
  }
}

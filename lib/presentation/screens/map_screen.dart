import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:manipulate_maps/constants/strings.dart';
import 'package:manipulate_maps/helpers/location_helper.dart';
import 'package:manipulate_maps/presentation/widgets/auth_feature_button.dart';
import '../../business_logic/cubit/phone_auth_cubit.dart';
import '../../constants/colors.dart';

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
  final _phoneAuthCubit = PhoneAuthCubit();

  static Position? location;
  final mapController = Completer<GoogleMapController>();

  Future<void> get currentLocation async {
    location = await LocationHelper.getcurrentPosition.whenComplete(() {
      setState(() {});
    });
  }

  static final CameraPosition myLocationCameraPosition = CameraPosition(
    target: LatLng(
      location!.latitude,
      location!.longitude,
    ),
    zoom: 15,
    bearing: 0.0,
    tilt: 0.0,
  );

  Widget buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: myLocationCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
      },
    );
  }

  Future<void> goToMyCurrentPosition() async {
    final GoogleMapController controller = await mapController.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(myLocationCameraPosition),
    );
  }

  @override
  void initState() {
    super.initState();
    currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            location != null
                ? buildGoogleMap()
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.headerColor,
                    ),
                  ),
            Positioned(
              child: BlocProvider(
                create: (context) => _phoneAuthCubit,
                child: AuthFeatureButton(
                    alignment: Alignment.topCenter,
                    onClickEvent: () async {
                      showProgressIndicator(context);
                      await _phoneAuthCubit.logOut();
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.pushReplacementNamed(
                        context,
                        authScreen,
                      );
                    },
                    text: 'Sign Out'),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 30),
          child: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            onPressed: goToMyCurrentPosition,
            child: Icon(
              Icons.place,
              color: AppColors.thirdColor,
            ),
          ),
        ),
      ),
    );
  }
}

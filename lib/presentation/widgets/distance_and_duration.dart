import 'package:flutter/material.dart';
import 'package:manipulate_maps/data/models/directions.dart';

class DistanceAndDuration extends StatelessWidget {
  const DistanceAndDuration({
    super.key,
    required this.isDateAndTimeVisible,
    this.placeDirections,
  });

  final bool isDateAndTimeVisible;
  final Directions? placeDirections;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDateAndTimeVisible,
      child: Text(placeDirections!.duration),
    );
  }
}

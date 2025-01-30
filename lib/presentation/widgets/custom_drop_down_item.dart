import 'package:flutter/material.dart';
import 'package:manipulate_maps/business_logic/models/country.dart';
import 'package:manipulate_maps/constants/colors.dart';

class CustomDropDownItem extends StatelessWidget {
  const CustomDropDownItem({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              country.flag,
              style: const TextStyle(
                fontSize: 18,
              ), // Display flag
            ),
            const SizedBox(width: 10), // Space between flag and country name
            Text(
              country.countryName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColors.darkColor,
              ),
            ),
            SizedBox(width: 30),
          ],
        ),
        Text(
          '+${country.phonePrefix}',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.darkColor,
          ),
        ), // Properly aligned country prefix
      ],
    );
  }
}

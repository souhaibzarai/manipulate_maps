import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../data/models/country.dart';

class CustomDropDownItem extends StatelessWidget {
  const CustomDropDownItem({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                country.flag,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Text(
            '+${country.phonePrefix}',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.darkColor,
            ),
          ), // Properly aligned country prefix
        ],
      ),
    );
  }
}

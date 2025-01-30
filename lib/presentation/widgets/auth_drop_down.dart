import 'package:flutter/material.dart';
import 'package:manipulate_maps/business_logic/models/country.dart';
import 'package:manipulate_maps/constants/data/countries.dart';
import 'package:manipulate_maps/presentation/widgets/custom_drop_down_item.dart';

import '../../constants/colors.dart';

class AuthDropDown extends StatefulWidget {
  const AuthDropDown({
    super.key,
    required this.setValue,
  });

  final void Function(Country country) setValue;

  @override
  State<AuthDropDown> createState() => _AuthDropDownState();
}

class _AuthDropDownState extends State<AuthDropDown> {
  OutlineInputBorder getInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: color,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: DropdownButtonFormField<Country>(
        dropdownColor: AppColors.thirdColor,
        autofocus: false,
        decoration: InputDecoration(
          labelText: "Select a Country",
          labelStyle: TextStyle(
            fontSize: 15,
            color: AppColors.headerColor,
          ),
          border: getInputBorder(AppColors.mainColor),
          enabledBorder: getInputBorder(AppColors.mainColor),
          focusedBorder: getInputBorder(AppColors.activeColor),
          errorBorder: getInputBorder(AppColors.errorColor),
        ),
        validator: (value) {
          if (value == null) {
            return 'You need to select a country prefix';
          }
          return null;
        },
        items: allCountries
            .map(
              (country) => DropdownMenuItem(
                value: country,
                child: CustomDropDownItem(country: country),
              ),
            )
            .toList(),
        onChanged: (country) {
          if (country != null) {
            widget.setValue(country);
          }
        },
      ),
    );
  }
}

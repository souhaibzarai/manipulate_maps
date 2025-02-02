import 'package:flutter/material.dart';
import '../../business_logic/models/country.dart';
import '../../constants/data/countries.dart';
import 'custom_drop_down_item.dart';

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
        elevation: 1,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Country code',
          labelStyle:const  TextStyle(
            fontSize: 12,
            color: AppColors.headerColor,
            overflow: TextOverflow.ellipsis,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          maintainHintHeight: true,
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
        items: shuffledCountries
            .map(
              (country) => DropdownMenuItem(
                value: country,
                key: ValueKey(country),
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

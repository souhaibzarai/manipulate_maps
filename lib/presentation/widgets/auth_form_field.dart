import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({super.key, this.isReadOnly = false, this.controller});

  final bool? isReadOnly;
  final TextEditingController? controller;

  OutlineInputBorder getInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: isReadOnly! ? AppColors.thirdColor : color,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  String getCountryFlag(String? countryID) {
    countryID ??= 'us';
    return countryID.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (flag) {
        return String.fromCharCode(flag.group(0)!.codeUnitAt(0) + 127397);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isReadOnly! ? 1 : 2,
      child: TextFormField(
        cursorColor: AppColors.darkColor,
        cursorErrorColor: AppColors.errorColor,
        readOnly: isReadOnly!,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              fontSize: 12, color: AppColors.darkColor, letterSpacing: 2),
          enabled: !isReadOnly!,
          border: getInputBorder(AppColors.mainColor),
          enabledBorder: getInputBorder(AppColors.mainColor),
          focusedBorder: getInputBorder(AppColors.activeColor),
          errorBorder: getInputBorder(AppColors.errorColor),
          labelText: isReadOnly! ? '${getCountryFlag(null)} +1' : '',
        ),
        validator: isReadOnly!
            ? null
            : (value) => value == null || value.isEmpty
                ? 'Make sure to enter a valid Phone Number'
                : value.toUpperCase().toString().contains(RegExp('[A-Z]'))
                    ? 'A Phone number cannot have alphabets [a-z]'
                    : value.length < 6
                        ? 'Phone number is too short'
                        : value.length > 11
                            ? 'Phone number is too long'
                            : null,
      ),
    );
  }
}

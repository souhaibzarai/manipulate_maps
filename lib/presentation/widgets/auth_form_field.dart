import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({super.key, this.controller});

  final TextEditingController? controller;

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
      flex: 2,
      child: TextFormField(
        cursorColor: AppColors.darkColor,
        cursorErrorColor: AppColors.errorColor,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 10, top: 20, right: 4, bottom: 20),
          hintText: 'Phone Number',
          hintStyle: TextStyle(fontSize: 13, color: AppColors.headerColor),
          border: getInputBorder(AppColors.mainColor),
          enabledBorder: getInputBorder(AppColors.mainColor),
          focusedBorder: getInputBorder(AppColors.activeColor),
          errorBorder: getInputBorder(AppColors.errorColor),
        ),
        validator: (value) => value == null || value.isEmpty
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

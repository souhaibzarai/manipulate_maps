import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/colors.dart';

class OTPField extends StatelessWidget {
  const OTPField({super.key, required this.verifyOTP});

  final void Function(String codeOTP, BuildContext ctx) verifyOTP;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      autoFocus: true,
      cursorColor: AppColors.darkColor,
      keyboardType: TextInputType.number,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldWidth: 40,
        fieldHeight: 50,
        borderWidth: 1,
        activeColor: AppColors.activeColor,
        inactiveColor: AppColors.activeColor,
        inactiveFillColor: AppColors.asTransparentColor,
        activeFillColor: AppColors.thirdColor,
        selectedColor: AppColors.secondaryColor,
        selectedFillColor: AppColors.transparentColor,
      ),
      animationDuration: Duration(milliseconds: 300),
      onCompleted: (code) {
        print('Completed | code is> $code');
        verifyOTP(code, context);
        print('code sent');
      },
      enableActiveFill: true,
    );
  }
}

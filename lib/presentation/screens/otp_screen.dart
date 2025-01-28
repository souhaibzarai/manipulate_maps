import 'package:flutter/material.dart';
import '../widgets/otp_field.dart';

import '../../constants/colors.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
    required this.phoneNumber,
  });

  final phoneNumber;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: 'Enter code sent to ',
                    style: TextStyle(
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                      color: AppColors.darkColor,
                    ),
                    children: [
                      TextSpan(
                        text: phoneNumber,
                        style: TextStyle(
                          fontSize: 19,
                          fontStyle: FontStyle.italic,
                          color: AppColors.headerColor,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 35),
              OTPField(),
            ],
          ),
        ),
      ),
    );
  }
}

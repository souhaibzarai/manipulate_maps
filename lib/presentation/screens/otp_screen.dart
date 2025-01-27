import 'package:flutter/material.dart';
import '../widgets/otp_field.dart';

import '../../constants/colors.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
  });

  final String phoneNumber = '+212 682421088';

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
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Enter code sent to ',
                    style: TextStyle(
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                      color: AppColors.darkColor,
                    ),
                  ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipulate_maps/constants/strings.dart';
import '../../business_logic/cubit/phone_auth_cubit.dart';
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

  Widget buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, mapScreen);
        }

        if (state is ErrorOccurred) {
          String errorMessage = state.errorMsg;

          Navigator.pop(context);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMessage),
            dismissDirection: DismissDirection.startToEnd,
            duration: Duration(seconds: 8),
            backgroundColor: AppColors.headerColor,
          ));
        }
      },
      child: Container(),
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
                        text: phoneNumber.toString(),
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
              SizedBox(height: 40),
              buildPhoneVerificationBloc(),
            ],
          ),
        ),
      ),
    );
  }
}

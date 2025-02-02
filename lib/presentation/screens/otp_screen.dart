import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/phone_auth_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../widgets/otp_field.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
    required this.phoneNumber,
  });

  final dynamic phoneNumber;

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
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
            duration: const Duration(seconds: 8),
            backgroundColor: AppColors.headerColor,
          ));
        }
      },
      child: Container(),
    );
  }

  void verifyOTP(String codeOTP, context) {
    showProgressIndicator(context);
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(codeOTP);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Enter code sent to ',
                      style: const TextStyle(
                        fontSize: 19,
                        fontStyle: FontStyle.italic,
                        color: AppColors.darkColor,
                      ),
                      children: [
                        TextSpan(
                          text: phoneNumber,
                          style: const TextStyle(
                            fontSize: 19,
                            fontStyle: FontStyle.italic,
                            color: AppColors.headerColor,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 35),
                OTPField(
                  verifyOTP: verifyOTP,
                ),
                const SizedBox(height: 35),
                buildPhoneVerificationBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

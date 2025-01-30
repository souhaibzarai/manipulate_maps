import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipulate_maps/business_logic/cubit/phone_auth_cubit.dart';
import 'package:manipulate_maps/constants/strings.dart';
import 'package:manipulate_maps/presentation/widgets/auth_feature_button.dart';

import '../../constants/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

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

class _MapScreenState extends State<MapScreen> {
  final _phoneAuthCubit = PhoneAuthCubit();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to map screen'),
              SizedBox(height: 40),
              BlocProvider<PhoneAuthCubit>(
                create: (context) => _phoneAuthCubit,
                child: AuthFeatureButton(
                  onClickEvent: () async {
                    showProgressIndicator(context);
                    await _phoneAuthCubit.logOut();
                    if (!context.mounted) {
                      return;
                    }
                    Navigator.pushReplacementNamed(context, authScreen);
                  },
                  alignment: Alignment.topCenter,
                  text: 'Log Out',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

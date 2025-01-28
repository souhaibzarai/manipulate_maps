import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/phone_auth_cubit.dart';
import 'constants/strings.dart';
import 'presentation/screens/authentication_screen.dart';
import 'presentation/screens/map_screen.dart';
import 'presentation/screens/otp_screen.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: AuthenticationScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OTPScreen(phoneNumber: phoneNumber),
          ),
        );

      case mapScreen:
        return MaterialPageRoute(
          builder: (context) => MapScreen(),
        );

      // case authScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => AuthenticationScreen(),
      //   );

      // case otpScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => OTPScreen(),
      //   );

      default:
        return null;
    }
  }
}

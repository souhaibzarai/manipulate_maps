import 'package:flutter/material.dart';
import 'package:manipulate_maps/constants/strings.dart';
import 'package:manipulate_maps/presentation/screens/authentication_screen.dart';
import 'package:manipulate_maps/presentation/screens/otp_screen.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return MaterialPageRoute(
          builder: (context) => AuthenticationScreen(),
        );

      case otpScreen:
        return MaterialPageRoute(
          builder: (context) => OTPScreen(),
        );

      // case authScreen:
      // return MaterialPageRoute(
      //   builder: (context) => BlocProvider.value(
      //     value: ,
      //     child: AuthenticationScreen(),
      //   ),
      // );

      // case otpScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider.value(
      //       value: ,
      //       child: OTPScreen(),
      //     ),
      //   );

      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:manipulate_maps/constants/strings.dart';
import 'package:manipulate_maps/presentation/screens/authentication.dart';
import 'package:manipulate_maps/presentation/screens/otp.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen :
        return MaterialPageRoute(
          builder: (context) => AuthenticationScreen(),
        );

      case otpScreen:
        return MaterialPageRoute(
          builder: (context) => OTPScreen(),
        );

      default:
        return null;
    }
  }
}

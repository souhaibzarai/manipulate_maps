import 'package:flutter/material.dart';
import 'package:manipulate_maps/presentation/screens/authentication.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => AuthenticationScreen(),
        );
    }

    return null;
  }
}

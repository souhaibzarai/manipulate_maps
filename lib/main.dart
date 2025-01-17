import 'package:flutter/material.dart';
import 'package:manipulate_maps/app_router.dart';

void main() {
  runApp(
    ManipulateApps(
      appRouter: AppRouter(),
    ),
  );
}

class ManipulateApps extends StatelessWidget {
  const ManipulateApps({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manipulate Maps',
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

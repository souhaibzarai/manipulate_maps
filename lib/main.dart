import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manipulate_maps/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

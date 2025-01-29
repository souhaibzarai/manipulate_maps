import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manipulate_maps/constants/strings.dart';
import 'app_router.dart';

late String _initialRoute;

void main() async {
  // TODO: remove avoid print from analysis_options.yaml

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.authStateChanges().listen((user) {
    user == null ? _initialRoute = authScreen : _initialRoute = mapScreen;
  });

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
      initialRoute: _initialRoute,
    );
  }
}

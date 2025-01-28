import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manipulate_maps/constants/strings.dart';

void main() async {
  // TODO: remove avoid print from analysis_options.yaml

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
    late String pageRoute;

    FirebaseAuth.instance.currentUser == null
        ? pageRoute = authScreen
        : pageRoute = mapScreen;

    return MaterialApp(
      title: 'Manipulate Maps',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: pageRoute,
    );
  }
}

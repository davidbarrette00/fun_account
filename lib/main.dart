import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/session_manager.dart';
import 'package:fun_account/state/TransactionPageState.dart';
import 'package:provider/provider.dart';

import 'route_generator.dart';
import 'constants/Routes.dart';

void main() async {
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
        brightness: MediaQuery.platformBrightnessOf(context),
        seedColor: const Color.fromARGB(255, 0, 255, 200)
    );
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TransactionPageState(), lazy: false),
        ],
        child: MaterialApp(
          title: 'Fun Account',
          theme: ThemeData(
            // colorScheme: colorScheme,
            // useMaterial3: true,
          ),
          initialRoute: Routes.login,//!SessionManager.isLoggedIn ? Routes.transactions : Routes.login,
          onGenerateRoute: ((settings) =>
              RouteGenerator.generateRoutes(settings)),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:fun_account/state/TransactionPageState.dart';
import 'package:provider/provider.dart';

import 'RouteGenerator.dart';
import 'constants/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TransactionPageState(), lazy: false),
        ],
        child: MaterialApp(
          title: 'Fun Account',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          initialRoute: Routes.transactions,
          onGenerateRoute: ((settings) =>
              RouteGenerator.generateRoutes(settings)),
        ));
  }
}

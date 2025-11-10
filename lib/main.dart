import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/session_manager.dart';
import 'package:fun_account/state/TransactionPageState.dart';
import 'package:provider/provider.dart';

import 'route_generator.dart';
import 'constants/Routes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestartWidget(
      child: MaterialApp()
  ));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

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
          title: 'In The Moment',
          theme: ThemeData(
            // colorScheme: colorScheme,
            // useMaterial3: true,
          ),
          initialRoute: SessionManager.isLoggedIn ? Routes.transactions : Routes.login,
          onGenerateRoute: ((settings) =>
              RouteGenerator.generateRoutes(settings)),
        ));
  }
}

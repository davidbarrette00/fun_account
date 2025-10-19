import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/pages/TransactionsPage.dart';
import 'package:fun_account/pages/LandingPage.dart';

import 'constants/Routes.dart';

class RouteGenerator {
  static Route<MaterialPageRoute> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
    //
    //

      case Routes.landing:
        return MaterialPageRoute(builder: ((context) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: getAppBar(context, Titles.landing),
            body: const LandingPage(
              title: Titles.landing,
            ),
          );
        }));

      case Routes.transactions:
      //home page
        return MaterialPageRoute(builder: ((context) {
          return Scaffold(
              appBar: getAppBar(context, Titles.transactions),
              body: const TransactionsPage(
                  title: Titles.transactions, transactionItems: []));
        }));

      case Routes.incentives:
      //home page
        return MaterialPageRoute(builder: ((context) {
          return Scaffold(
              appBar: getAppBar(context, Titles.incentives),
              body: const Placeholder());
        }));
      default:
        return _errorRoute();
    }
  }

  static AppBar getAppBar(BuildContext context, String title) {
    return AppBar(
        // leading: Image.asset(
        //   'images/logo.png',
        //   width: 200,
        //   height: 200,
      // ),
      // ),
      // ),
        actions: getAppbarLoggedInActions(context),
        title: Text(title));
  }

  static List<Widget>? getAppbarLoggedInActions(BuildContext context) {
    return [
      ElevatedButton(
          onPressed: (() =>
              Navigator.pushNamed(context, Routes.transactions)),
          child: const Text("Transactions")),
      // ElevatedButton(
      //     onPressed: (() =>
      //         Navigator.pushReplacementNamed(context, Routes.incentives)),
      //     child: const Text("Incentives")),
      ElevatedButton(
          onPressed: () {
            // SessionManager.logout(context);
          },
          child: const Text("Logout")),
      const SizedBox(
        width: 100,
      )
    ];
  }

  static Route<MaterialPageRoute> _errorRoute() {
    return MaterialPageRoute(builder: ((context) {
      return Scaffold(
        body: Center(
            child: Column(
              children: const [
                Text("Error In RouteGenerator"),
              ],
            )),
      );
    }));
  }
}
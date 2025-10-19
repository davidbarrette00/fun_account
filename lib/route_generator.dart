import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/pages/transactions_page.dart';
import 'package:fun_account/pages/landing_page.dart';
import 'package:fun_account/session_manager.dart';

import 'constants/Routes.dart';

class RouteGenerator {
  static Route<MaterialPageRoute> generateRoutes(RouteSettings settings) {
    if (SessionManager.isLoggedIn) {
      return handleLoggedIn(settings);
    } else {
      return handleNotLoggedIn(settings);
    }
  }

  static Route<MaterialPageRoute> handleLoggedIn(RouteSettings settings){
    switch (settings.name) {
    //
    //
      case Routes.transactions:
      //home page
        return MaterialPageRoute(builder: ((context) {
          return Scaffold(
              appBar: getAppBar(context, Titles.transactions),
              body: const TransactionsPage(
                  title: Titles.transactions, transactionItems: []));
        }));
      //
      //
      case Routes.incentives:
      //home page
        return MaterialPageRoute(builder: ((context) {
          return Scaffold(
              appBar: getAppBar(context, Titles.incentives),
              body: const Placeholder());
        }));
      //
      //
      default:
        return _errorRoute();
    }
  }


  static Route<MaterialPageRoute> handleNotLoggedIn(RouteSettings settings){
    switch (settings.name) {

      case Routes.login:
      //home page
        return MaterialPageRoute(builder: ((context) {
          return Scaffold(
              appBar: getAppBar(context, Titles.transactions),
              body: const TransactionsPage(
                  title: Titles.transactions, transactionItems: []));
        }));

      default:
        return _errorRoute();
    }
  }

  static AppBar getAppBar(BuildContext context, String title) {
    List<Widget>? appBarActions;

    if(SessionManager.isLoggedIn){
      //Handle Logged in appbar
      appBarActions = [
        ElevatedButton(
            onPressed: (() =>
                Navigator.pushReplacementNamed(context, Routes.transactions)),
            child: const Text("Transactions")),
        ElevatedButton(
            onPressed: () {
              SessionManager.logout(context);
            },
            child: const Text("Logout")),
        const SizedBox(
          width: 100,
        )
      ];
    } else {
      //Handle Not Logged in appbar
      appBarActions = [];
    }

    return AppBar(
        actions: appBarActions,
        title: Text(title));
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
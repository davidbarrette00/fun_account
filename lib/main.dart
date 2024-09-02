import 'package:flutter/material.dart';
import 'package:fun_account/model/Transactions/TransactionItem.dart';

import 'components/transactions/TransactionsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fun Account',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const TransactionsPage(title: 'Transactions'),
    );
  }
}

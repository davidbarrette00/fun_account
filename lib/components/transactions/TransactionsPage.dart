import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/components/transactions/TransactionModalBottomSheet.dart';
import 'package:provider/provider.dart';

import '../../model/TransactionListModel.dart';
import 'TransactionListItem.dart';

class TransactionsPage extends StatefulWidget {
  TransactionsPage(
      {super.key, required this.title, required this.transactionItems});

  final List<TransactionListItem> transactionItems;
  final String title;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final double TRANSACTION_LIST_HEIGHT =
      500; //MediaQuery.sizeOf(context).width * 0.8;
  final double TRANSACTION_LIST_WIDTH = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<TransactionListModel>(builder: (context, value, child) {
                return Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    height: TRANSACTION_LIST_HEIGHT,
                    width: TRANSACTION_LIST_WIDTH,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: value.transactionItems
                          .toList(), //don't remove "toList()"
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          style: TextStyle(fontSize: 20),
                          "Number of transactions: ${value.transactionItems.length}"),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            style: TextStyle(fontSize: 20),
                            "Transaction total: ${value.transactionTotal}"),
                        Text(
                            style: TextStyle(fontSize: 20),
                            "Payment total: ${value.paymentTotal}"),
                      ]),
                ]);
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addListItem(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addListItem(context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return TransactionModalBottomSheet();
      },
    );
  }
}

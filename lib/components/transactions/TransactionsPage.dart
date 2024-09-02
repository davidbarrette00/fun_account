import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TransactionInput.dart';
import '../../model/Transactions/TransactionItem.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key, required this.title});

  final String title;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  final double TRANSACTION_LIST_HEIGHT = 500; //MediaQuery.sizeOf(context).width * 0.8;
  final double TRANSACTION_LIST_WIDTH = 400;

  List<TransactionItem> transactionItems = List.empty(growable: true);


  void _addListItem() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return TransactionInput();
      },
    );
    setState(() {
      transactionItems.add(TransactionItem());
    });
  }

  void _removeListItem() {
    if (transactionItems.isEmpty) return;
    setState(() {
      transactionItems.removeLast();
    });
  }

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
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  height: TRANSACTION_LIST_HEIGHT,
                  width: TRANSACTION_LIST_WIDTH,
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      children: transactionItems.toList(), //don't remove "toList()"
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      style: TextStyle(fontSize: 20),
                        "Number of transactions: ${transactionItems.length}"
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _removeListItem,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: _addListItem,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

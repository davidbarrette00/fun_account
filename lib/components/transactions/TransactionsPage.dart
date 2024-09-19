import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/components/transactions/TransactionModalBottomSheet.dart';
import 'package:provider/provider.dart';

import '../../state/TransactionPageState.dart';
import 'TransactionListItem.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage(
      {super.key, required this.title, required this.transactionItems});

  final List<TransactionListItem> transactionItems;
  final String title;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final double TRANSACTION_LIST_HEIGHT = 500; //MediaQuery.sizeOf(context).width * 0.8;
  final double TRANSACTION_LIST_WIDTH = 400;

  void initState(){
    TransactionPageState transactionPageState = Provider.of<TransactionPageState>(context, listen: false);
    for(double i = 1; i < 5; i++) {
      transactionPageState.addTransaction(TransactionListItem("Transaction $i",false, i, 1));
    }
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
              Consumer<TransactionPageState>(builder: (context, value, child) {
                return Column(children: [
                  Text(
                      style: TextStyle(fontSize: 20),
                      "Fun Account Balance: ${value.balance}"),
                  SizedBox.fromSize(size: const Size(double.maxFinite, 30),),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    height: TRANSACTION_LIST_HEIGHT,
                    width: TRANSACTION_LIST_WIDTH,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: value.transactionItems.toList(),
                    ),
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
        tooltip: 'Add Transaction',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addListItem(context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const TransactionModalBottomSheet();
      },
    );
  }
}

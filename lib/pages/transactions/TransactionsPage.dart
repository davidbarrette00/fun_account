import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/TransactionPageState.dart';
import 'TransactionListItem.dart';
import 'TransactionModalBottomSheet.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage(
      {super.key, required this.title, required this.transactionItems});

  final List<TransactionListItem> transactionItems;
  final String title;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  double TRANSACTION_LIST_HEIGHT = 0.60;
  double TRANSACTION_LIST_WIDTH = 0.90;

  late TransactionPageState transactionPageState;

  TextEditingController transactionFilterController = TextEditingController();

  @override
  void initState() {
    transactionPageState =
        Provider.of<TransactionPageState>(context, listen: false);


    Set<String> chars = {'a', 's,'};
    for (int i = 1; i <= 8; i++) {
      var random = Random();
      var randomChar = chars.elementAt(random.nextInt(chars.length));
      if(random.nextInt(2) == 1){
        transactionPageState.addTransaction(
            TransactionListItem("${randomChar}Transaction $i", false, i * 1.0, 1));
      } else {
        transactionPageState.addTransaction(
            TransactionListItem("${randomChar}Transaction Payment $i", true, i * 1.0, 1));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var windowWidth = MediaQuery.of(context).size.width;
    var windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<TransactionPageState>(
                    builder: (context, state, child) {
                  return Column(children: [
                    Text(
                        style: const TextStyle(fontSize: 20),
                        "Fun Account Balance: ${state.balance}"),
                    TextField(
                      onChanged: (value) =>
                          state.updateTransactionFilter(value),
                      controller: transactionFilterController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => {
                                  transactionFilterController.clear(),
                                  state.updateTransactionFilter("")
                                }),
                        border: const OutlineInputBorder(),
                        labelText: 'Filter Transactions',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Show only payments"),
                        Checkbox(
                          checkColor: Colors.white,
                          value: state.transactionFilterIsPayment == 0,
                          onChanged: (bool? value) {
                            if(state.transactionFilterIsPayment == -1 ||
                                state.transactionFilterIsPayment == 1) {
                               state.updateTransactionFilterIsPayment(0);
                            } else {
                               state.updateTransactionFilterIsPayment(-1);
                            }
                          },
                        ),
                        Text("Show only non-payments"),
                        Checkbox(
                          checkColor: Colors.white,
                          value: state.transactionFilterIsPayment == 1,
                          onChanged: (bool? value) {
                            if(state.transactionFilterIsPayment == -1 ||
                                state.transactionFilterIsPayment == 0) {
                              state.updateTransactionFilterIsPayment(1);
                            } else {
                              state.updateTransactionFilterIsPayment(-1);
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox.fromSize(
                      size: const Size(double.maxFinite, 30),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      height: TRANSACTION_LIST_HEIGHT * windowHeight,
                      width: TRANSACTION_LIST_WIDTH * windowWidth,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: state.transactionItems
                            .where((item) =>
                              item.description.toLowerCase().startsWith(state.transactionFilter.toLowerCase())
                              &&
                                  ((state.transactionFilterIsPayment == -1) ||
                              (state.transactionFilterIsPayment == 0 && item.isPayment) ||
                              (state.transactionFilterIsPayment == 1 && !item.isPayment)))
                            .toList(),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                style: const TextStyle(fontSize: 20),
                                "Total Spent: ${state.transactionTotal}"),
                            Text(
                                style: const TextStyle(fontSize: 20),
                                "Total Paid: ${state.paymentTotal}"),
                          ]),
                    ),
                  ]);
                    }
                ),
              ],
            ),
          );
        }),
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
    showModalBottomSheet<TransactionModalBottomSheet>(
      context: context,
      builder: (BuildContext context) {
        return const TransactionModalBottomSheet();
      },
    );
  }
}

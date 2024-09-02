import 'package:flutter/cupertino.dart';

import '../components/transactions/TransactionListItem.dart';

class TransactionListModel extends ChangeNotifier {

  List<TransactionListItem> transactionItems = List.empty(growable: true);

  void addTransaction(TransactionListItem transaction) {
    transactionItems.add(transaction);
    notifyListeners();
  }

  void removeTransaction() {
    if (transactionItems.isEmpty) { return; }

    transactionItems.removeLast();
    // transactionItems.remove(transaction);
    notifyListeners();
  }
}

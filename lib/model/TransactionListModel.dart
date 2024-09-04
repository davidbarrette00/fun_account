import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../components/transactions/TransactionListItem.dart';

class TransactionListModel extends ChangeNotifier {

  List<TransactionListItem> transactionItems = List.empty(growable: true);

  double transactionTotal = 0;
  double paymentTotal = 0;

  void addToTransactionTotal(double amount, double multiplier) {
    transactionTotal += amount * multiplier;
    notifyListeners();
  }

  void addToPaymentTotal(double amount, double multiplier) {
    paymentTotal += amount * multiplier;
    notifyListeners();
  }

  void addTransaction(TransactionListItem transaction) {
    transactionItems.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Uuid id) {
    if (transactionItems.isEmpty) { return; }

    for(TransactionListItem transaction in transactionItems) {
      if (transaction.id == id) {
        transactionItems.remove(transaction);
        break;
      }
    }
    notifyListeners();
  }
}

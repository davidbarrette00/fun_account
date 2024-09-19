import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../components/transactions/TransactionListItem.dart';

class TransactionPageState extends ChangeNotifier {

  List<TransactionListItem> transactionItems = List.empty(growable: true);

  double transactionTotal = 0;
  double paymentTotal = 0;
  double balance = 0;

  void addTransaction(TransactionListItem transaction) {
    transactionTotal += transaction.amount * transaction.multiplier;
    transactionItems.add(transaction);

    balance = paymentTotal - transactionTotal;
    notifyListeners();
  }

  void removeTransaction(String id) {
    if (transactionItems.isEmpty) { return; }

    for(TransactionListItem transaction in transactionItems) {
      if (transaction.id == id) {
        transactionTotal -= transaction.amount;
        transactionItems.remove(transaction);
        break;
      }
    }

    balance = paymentTotal - transactionTotal;
    notifyListeners();
  }

  void handleChangedTransactionValue(bool isPayment, double amount){
    if(isPayment){
      paymentTotal += amount;
    } else {
      transactionTotal += amount;
    }

    balance = paymentTotal - transactionTotal;
    notifyListeners();
  }

  void handleChangeToPaymentStatus(bool newIsPayment, double amount) {
    if(newIsPayment){
      paymentTotal += amount;
      transactionTotal -= amount;
    } else {
      transactionTotal += amount;
      paymentTotal -= amount;
    }

    balance = paymentTotal - transactionTotal;
    notifyListeners();
  }
}

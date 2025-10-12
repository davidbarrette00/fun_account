import 'package:flutter/cupertino.dart';

import '../pages/transactions/TransactionListItem.dart';


class TransactionPageState extends ChangeNotifier {

  List<TransactionListItem> transactionItems = List.empty(growable: true);

  double debitTotal = 0;
  double creditTotal = 0;

  String transactionFilter = "";
  int transactionFilterIsPayment = -1;

  void addTransaction(TransactionListItem transaction) {
    if(transaction.isCredit) {
      creditTotal += transaction.amount * transaction.multiplier;
    } else {
      debitTotal += transaction.amount * transaction.multiplier;
    }

    transactionItems.add(transaction);
    notifyListeners();
  }

  void removeTransaction(String id) {
    if (transactionItems.isEmpty) { return; }

    for(TransactionListItem transaction in transactionItems) {
      if (transaction.id == id) {

        if(transaction.isCredit) {
          creditTotal -= transaction.amount * transaction.multiplier;
        } else {
          debitTotal -= transaction.amount * transaction.multiplier;
        }
        transactionItems.remove(transaction);
        break;
      }
    }
    notifyListeners();
  }

  void handleChangedTransactionValue(bool isCredit, double amount){
    if(isCredit){
      creditTotal += amount;
    } else {
      debitTotal += amount;
    }
    notifyListeners();
  }

  void handleChangeToPaymentStatus(bool newIsPayment, double amount) {
    if(newIsPayment){
      creditTotal += amount;
      debitTotal -= amount;
    } else {
      debitTotal += amount;
      creditTotal -= amount;
    }

    notifyListeners();
  }

  void updateTransactionFilter(String value) {
    this.transactionFilter = value;
    notifyListeners();
  }

  void updateTransactionFilterIsPayment(int value) {
    this.transactionFilterIsPayment = value;
    notifyListeners();
  }

  void clear(){
    transactionItems.clear();
    debitTotal = 0;
    creditTotal = 0;
    transactionFilter = "";
    transactionFilterIsPayment = -1;
    notifyListeners();
  }
}

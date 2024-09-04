import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/model/TransactionListModel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TransactionListItem extends StatelessWidget {
  TransactionListItem(this.description, this.amount, this.multiplier, {super.key});

  String description = "description";
  double amount = 0;
  double multiplier = 1;

  Uuid id = Uuid();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black,),
        ),

        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(description),
          Text(amount.toString()),
          Text(multiplier.toString()),
          IconButton(
            icon: Icon(CupertinoIcons.trash),
            splashColor: Colors.blue,
            onPressed: () => Provider.of<TransactionListModel>(context, listen: false).removeTransaction(id),
          )
        ]),
      ),
    );
  }
}

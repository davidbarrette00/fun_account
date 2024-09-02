import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  TransactionListItem(this.description, this.amount, this.multiplier, {super.key});

  String description = "description";
  double amount = 0;
  double multiplier = 1;

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
          Text(multiplier.toString())
        ]),
      ),
    );
  }
}

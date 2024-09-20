import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_account/state/TransactionPageState.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TransactionListItem extends StatefulWidget {
  TransactionListItem(
      this.description, this.isPayment, this.amount, this.multiplier,
      {super.key});

  final String id = const Uuid().v4();
  final DateTime date = DateTime.now();

  String description;
  bool isPayment;
  double amount;
  double multiplier;

  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  final listItemWidth = 350;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  String formatDate(){
    return
    widget.date.day.toString() + "/" + widget.date.month.toString() + "  " + widget.date.hour.toString() + ":" + widget.date.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    var paymentWithSign = (widget.amount * widget.multiplier).toString();
    if (widget.isPayment == false) {
      paymentWithSign = "-$paymentWithSign";
    }

    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: ExpansionTile(
        // showTrailingIcon: false,
        trailing: Icon(Icons.edit),
        title: ListTile(
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(widget.description),
            Text(paymentWithSign.toString()),
            IconButton(
              icon: const Icon(CupertinoIcons.trash),
              splashColor: Colors.blue,
              onPressed: () =>
                  Provider.of<TransactionPageState>(context, listen: false)
                      .removeTransaction(widget.id),
            )
          ]),
        ),
        subtitle: Text(formatDate()),
        backgroundColor: Colors.grey[600],
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        children: getTransactionListItemEdit(),
      ),
    );
  }

  getTransactionListItemEdit() {
    return [
        Divider(color: Colors.grey[900],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.id.substring(widget.id.length-12, widget.id.length)),
            Text(widget.date.toString()),
          ],
        ),
        Row(
          children: [
            Text("Is Payment?"),
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: widget.isPayment,
              onChanged: (bool? value) {
                setState(() {
                  widget.isPayment = value!;
                  Provider.of<TransactionPageState>(context, listen: false).handleChangeToPaymentStatus(widget.isPayment, widget.amount * widget.multiplier);
                });
              },
            ),
          ],
        ),
        TextFormField(
          initialValue: widget.description,
          onChanged: (value) => setState(() {
            widget.description = value;
          }),
        ),

        TextFormField(
          keyboardType: TextInputType.number,
          initialValue: widget.amount.toString(),
          onChanged: (value) => setState(() {
            double oldAmount = widget.amount;
            widget.amount = double.parse(value);

            Provider.of<TransactionPageState>(context, listen: false).handleChangedTransactionValue(widget.isPayment, widget.amount * widget.multiplier - oldAmount * widget.multiplier);
          }),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          initialValue: widget.multiplier.toString(),
          onChanged: (value) => setState(() {
            double oldAmount = widget.multiplier;
            widget.multiplier = double.parse(value);

            Provider.of<TransactionPageState>(context, listen: false).handleChangedTransactionValue(widget.isPayment, widget.amount * widget.multiplier - widget.amount * oldAmount);
          }),
        ),
      ];
  }
}

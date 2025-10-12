import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_account/state/TransactionPageState.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TransactionListItem extends StatefulWidget {
  TransactionListItem(
      this.description, this.isCredit, this.amount, this.multiplier,
      {super.key});

  final String id = const Uuid().v4();
  final DateTime date = DateTime.now();

  String description;
  bool isCredit;
  double amount;
  double multiplier;

  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  final listItemWidth = 350;

  final double DESCRIPTION_WIDTH = 125;

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  String formatDate() {
    return "${widget.date.day}/${widget.date.month}  ${widget.date.hour}:${widget.date.minute}";
  }

  @override
  Widget build(BuildContext context) {
    var windowWidth = MediaQuery.of(context).size.width;
    var windowHeight = MediaQuery.of(context).size.height;

    var paymentWithSign = (widget.amount * widget.multiplier).toString();
    if (!widget.isCredit) {
      paymentWithSign = "-$paymentWithSign";
    }

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: ExpansionTile(
        showTrailingIcon: false,
        trailing: const Icon(Icons.edit),
        title: ListTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
                width: DESCRIPTION_WIDTH, child: Text(widget.description)),
            Text(paymentWithSign.toString()),
            IconButton(
              icon: const Icon(CupertinoIcons.trash),
              splashColor: Colors.blue,
              onPressed: () =>
                  Provider.of<TransactionPageState>(context, listen: false)
                      .removeTransaction(widget.id),
            ),
            const Icon(Icons.edit)
          ]),
        ),
        backgroundColor: Colors.grey[600],
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        children: getTransactionListItemEdit(),
      ),
    );
  }

  getTransactionListItemEdit() {
    return [
      Divider(
        color: Colors.grey[900],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(widget.id.substring(widget.id.length - 12, widget.id.length)),
          Text(widget.date.toString()),
        ],
      ),
      Row(
        children: [
          const Text("Is Payment?"),
          Checkbox(
            checkColor: Colors.white,
            fillColor: WidgetStateProperty.resolveWith(getColor),
            value: widget.isCredit,
            onChanged: (bool? value) {
              setState(() {
                widget.isCredit = value!;
                Provider.of<TransactionPageState>(context, listen: false)
                    .handleChangeToPaymentStatus(
                        widget.isCredit, widget.amount * widget.multiplier);
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
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
        ],
        onChanged: (value) => setState(() {
          double oldAmount = widget.amount;
          widget.amount = double.parse(value);

          Provider.of<TransactionPageState>(context, listen: false)
              .handleChangedTransactionValue(
                  widget.isCredit,
                  widget.amount * widget.multiplier -
                      oldAmount * widget.multiplier);
        }),
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        initialValue: widget.multiplier.toString(),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) => setState(() {
          double oldAmount = widget.multiplier;
          widget.multiplier = double.parse(value);

          Provider.of<TransactionPageState>(context, listen: false)
              .handleChangedTransactionValue(
                  widget.isCredit,
                  widget.amount * widget.multiplier -
                      widget.amount * oldAmount);
        }),
      ),
    ];
  }
}

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/TransactionListModel.dart';
import 'TransactionListItem.dart';

class TransactionModalBottomSheet extends StatefulWidget {
  const TransactionModalBottomSheet({super.key});

  @override
  State<TransactionModalBottomSheet> createState() =>
      _TransactionModalBottomSheetState();
}

class _TransactionModalBottomSheetState
    extends State<TransactionModalBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController multiplierController = TextEditingController();

  String description = "description_placeholder";
  int amount = 0;
  int multiplier = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 500,
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Add Transaction'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter description',
                  labelText: 'Description',
                ),
                controller: descriptionController,
                onChanged: (String value) {
                  descriptionController.text = value;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter amount',
                  labelText: 'Amount',
                ),
                controller: amountController,
                onChanged: (String value) {
                  amountController.text = value;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter multiplier',
                  labelText: 'Multiplier',
                ),
                controller: multiplierController,
                onChanged: (String value) {
                  multiplierController.text = value;
                },
              ),
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {

                    String description = (descriptionController.text.isEmpty) ? "description_placeholder" :descriptionController.text;
                    double amount = (amountController.text.isEmpty) ? -1 : double.parse(amountController.text);
                    double multiplier = (multiplierController.text.isEmpty) ? 0 : double.parse(multiplierController.text);

                    final newTransaction = new TransactionListItem(
                            description,
                            amount,
                            multiplier);

                    setState(() {
                      Provider.of<TransactionListModel>(context, listen: false)
                          .addTransaction(newTransaction);
                    });
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

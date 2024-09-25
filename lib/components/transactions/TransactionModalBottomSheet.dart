import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../state/TransactionPageState.dart';
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

  bool isPayment = false;
  String description = "description_placeholder";
  int amount = 0;
  int multiplier = 0;

  @override
  Widget build(BuildContext context) {
    TransactionPageState transactionPageState =
        Provider.of<TransactionPageState>(context, listen: false);

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
              Row(
                children: [
                  const Text("Is this a payment?"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: WidgetStateProperty.resolveWith(getColor),
                    value: isPayment,
                    onChanged: (bool? value) {
                      setState(() {
                        isPayment = value!;
                      });
                    },
                  ),
                ],
              ),
              Autocomplete<String>(onSelected: (String selection) {
                descriptionController.text = selection;
              }, optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isNotEmpty) {
                  descriptionController.text = textEditingValue.text;

                  List<String> suggestions = <String>[];
                  for (TransactionListItem item
                      in transactionPageState.transactionItems) {
                    if (item.description.startsWith(textEditingValue.text) &&
                        suggestions.contains(item.description) == false) {
                      suggestions.add(item.description);
                    }
                  }

                  return suggestions;
                }
                return [];
              }),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter amount',
                  labelText: 'Amount',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: amountController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter multiplier',
                  labelText: 'Multiplier',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: multiplierController,
              ),
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    String description = (descriptionController.text.isEmpty)
                        ? "description_placeholder"
                        : descriptionController.text;
                    double amount = (amountController.text.isEmpty)
                        ? 1
                        : double.parse(amountController.text);
                    double multiplier = (multiplierController.text.isEmpty)
                        ? 1
                        : double.parse(multiplierController.text);

                    final newTransaction = TransactionListItem(
                      description,
                      isPayment,
                      amount,
                      multiplier,
                    );

                    setState(() {
                      transactionPageState.addTransaction(newTransaction);
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

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _subbmitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    String title = _titleController.text;
    double amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget._addNewTransaction(
      title,
      amount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(
        () {
          _selectedDate = pickedDate;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  onSubmitted: (_) => _subbmitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No Date Chosen !'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                      // TextButton(
                      //   onPressed: _presentDatePicker,
                      //   child: Text(
                      //     'Choose Date',
                      //     style: TextStyle(
                      //       color: Theme.of(context).primaryColor,
                      //       fontWeight: FontWeight.w600,
                      //       fontFamily: Theme.of(context)
                      //           .textTheme
                      //           .headline6
                      //           ?.fontFamily,
                      //     ),
                      //   ),
                      // ),
                      AdaptiveFlatButton(
                        'Choose Date',
                        _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _subbmitData,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'Add transaction',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amoutContoller = TextEditingController();
  final Function onNewTransaction;

  NewTransaction(this.onNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amout'),
              controller: amoutContoller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amoutContoller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    onNewTransaction(enteredTitle, enteredAmount);
  }
}

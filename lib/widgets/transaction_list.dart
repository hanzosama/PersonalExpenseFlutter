// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2)),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$${transactions[index].amount}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transactions[index].title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat()
                          .add_yMMMEd()
                          .format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    )
                  ]),
            ]),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}

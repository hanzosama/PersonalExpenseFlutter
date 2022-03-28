// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appBartitleTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    var titleTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          textTheme: TextTheme(
            titleLarge: titleTextStyle,
            titleMedium: titleTextStyle,
            titleSmall: titleTextStyle,
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: appBartitleTextStyle,
          ),
          errorColor: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    )
  ];

  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = _buildAppBar(context);

    final txWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final mainPageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (isLandscape)
          ..._buildLandscapeContent(
            mediaQuery,
            appBar,
            txWidget,
          ),
        if (!isLandscape)
          ..._buildPortraintContent(
            mediaQuery,
            appBar,
            txWidget,
          ),
      ]),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: mainPageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: mainPageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startNewTransaction(context),
                  ),
          );
  }

  Widget _buildAppBar(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses App',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startNewTransaction(context),
                  child: Icon(Icons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses App',
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startNewTransaction(context),
              ),
            ],
          );
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (show) {
              setState(() {
                _showChart = show;
              });
            },
          )
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txWidget
    ];
  }

  List<Widget> _buildPortraintContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txWidget
    ];
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//widgets
import './widgets/new_transaction.dart';
import './widgets/transcation_list.dart';
import './widgets/chart.dart';

//models
import './models/transaction.dart';

const globalPrimaryColor = Color.fromARGB(125, 19, 58, 131);
const globalAccentColor = Color.fromARGB(167, 255, 193, 7);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpensesApp Demo - Flutter',
      theme: ThemeData(
        primaryColor: globalPrimaryColor,
        accentColor: globalAccentColor,
        fontFamily: "Quicksand",
        errorColor: Color.fromARGB(171, 255, 0, 0),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(183, 168, 0, 197),
              ),
              headline5: const TextStyle(
                fontFamily: 'Opensans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(183, 168, 0, 197),
              ),
              button: const TextStyle(
                color: Colors.white,
                // backgroundColor: globalPrimaryColor,
              ),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: globalPrimaryColor,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = true;
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 12,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 2.22,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries12',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries312',
      amount: 19,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries123112',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 2.22,
      date: DateTime.now().subtract(const Duration(days: 9)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenData) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenData,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(
      () {
        _userTransactions.removeWhere((tx) => tx.id == id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        "ExpensesApp",
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    var switchChart = SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_recentTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.23,
              child: Chart(_userTransactions),
            ),
          if (!isLandscape) txListWidget,
          if (isLandscape) switchChart,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_userTransactions),
                  )
                : txListWidget
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

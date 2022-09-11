import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _userTransactions;
  Function _deleteTransaction;

  TransactionList(List<Transaction> list, Function deleteTransaction2) {
    _userTransactions = list.reversed.toList();
    _deleteTransaction = deleteTransaction2;
  }

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: ((context, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet !',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontWeight: FontWeight.bold,
                    ), //textTheme.headline6,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            }),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            '\$${_userTransactions[index].amount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(187, 0, 0, 0),
                              fontFamily: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle
                                  .fontFamily,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(187, 0, 0, 0),
                        fontFamily: Theme.of(context)
                            .appBarTheme
                            .titleTextStyle
                            .fontFamily,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_userTransactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            onPressed: () =>
                                _deleteTransaction(_userTransactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                _deleteTransaction(_userTransactions[index].id),
                          ),
                  ));
            },
            itemCount: _userTransactions.length,
          );
  }
}


// Card(
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).primaryColor,
//                             width: 2,
//                           ),
//                         ),
//                         child: Text(
//                           "\$${_userTransactions[index].amount.toStringAsFixed(2)}",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _userTransactions[index].title,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             DateFormat.yMMMd()
//                                 .format(_userTransactions[index].date),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
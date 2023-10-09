import 'package:flutter/material.dart';
import 'package:wallet_tracker/components/top_card.dart';
import 'package:wallet_tracker/my_app.dart';
import 'components/transaction.dart';



class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final List<Transaction> transactions = [];
  String totalIncome(){
    double balance =0;
    for (var i = 0; i < transactions.length ; i++ ){
      if (transactions[i].expenseOrIncome == 'income')
      {
        balance += transactions[i].money;
      }
    }
    return balance.toStringAsFixed(2);
  }

  String totalExpense(){
    double balance =0;
    for (var i = 0; i < transactions.length ; i++ ){
      if (transactions[i].expenseOrIncome == 'expense')
        {
          balance += transactions[i].money;
        }
    }
    return balance.toStringAsFixed(2);
  }

  String totalBalance(){
    double income =0 , expense =0 ,balance =0;
    for (var i = 0; i < transactions.length ; i++ ){
      if (transactions[i].expenseOrIncome == 'income')
        {
          income += transactions[i].money;
        }
    }
    for (var i = 0; i < transactions.length ; i++ ){
      if (transactions[i].expenseOrIncome == 'expense')
        {
          expense += transactions[i].money;
        }
    }
    balance = income -expense;
    return balance.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            TopCard(
                balance: totalBalance(),
                income: totalIncome(),
                expense: totalExpense(),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (ctx,index) {
                      return Transaction(
                          transactionName: transactions[index].transactionName,
                          money: transactions[index].money,
                          expenseOrIncome: transactions[index].expenseOrIncome,
                      );
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}

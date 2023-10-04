import 'package:flutter/material.dart';
import 'package:wallet_tracker/components/adding_box.dart';
import 'package:wallet_tracker/components/top_card.dart';
import 'components/transaction.dart';


class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  List <Transaction> transactions = [];

  final TextEditingController  _transactionNameController = TextEditingController();
  final TextEditingController _transactionAmountController = TextEditingController();
  String _transactionStatusController ='';

  void createBoxExpense(){
    showDialog(
        context: context,
        builder: (context){
          return AddingBox(
              title: _transactionNameController,
              amount: _transactionAmountController,
              onSave: addTransaction,
              onCancel: cancelAddingTransaction,
              expenseOrIncome:(selectedCategory){
                _transactionStatusController = selectedCategory;
              },
          );
        }
    );
  }

  void addTransaction(){
    final title = _transactionNameController.text;
    final amount = double.parse(_transactionAmountController.text);
    final status = _transactionStatusController;


    if (title.isNotEmpty && amount > 0){
      setState(() {
        transactions.add(Transaction(transactionName: title, money: amount, expenseOrIncome: status));
        _transactionNameController.clear();
        _transactionAmountController.clear();
      });
    }
    Navigator.of(context).pop();
  }

  void cancelAddingTransaction(){
    _transactionNameController.clear();
    _transactionAmountController.clear();
    Navigator.of(context).pop();
  }

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
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey.shade600,
            onPressed: createBoxExpense,
            child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

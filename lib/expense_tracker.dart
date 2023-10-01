import 'package:flutter/material.dart';
import 'package:wallet_tracker/components/adding_box.dart';
import 'package:wallet_tracker/components/top_card.dart';
import 'components/expense.dart';


class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final List<Expense> _expenses = [];

  TextEditingController  _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  void createBoxExpense(){
    showDialog(
        context: context,
        builder: (context){
          return AddingBox(
              title: _titleController,
              amount: _amountController,
              onSave: addExpense,
              onCancel: cancelAddingExpense,
          );
        }
    );
  }

  void addExpense(){
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);


    if (title.isNotEmpty && amount > 0){
      setState(() {
        _expenses.add(Expense(title, amount));
        _titleController.clear();
        _amountController.clear();
      });
    }
    Navigator.of(context).pop();
  }

  void cancelAddingExpense(){
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  String totalExpense(){
    double balance =0;
    for (var i = 0; i < _expenses.length ; i++ ){
      balance += _expenses[i].amount;
    }
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
                balance: '100',
                income: '100',
                expense: totalExpense(),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (ctx,index){
                    return Card(
                      elevation: 2,
                      margin:const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
                      child: ListTile(
                        title: Text(_expenses[index].title),
                        subtitle: Text('\$${_expenses[index].amount.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: (){
                            setState(() {
                              _expenses.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                )
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createBoxExpense,
            child: const Icon(Icons.add),

        ),
      ),
    );
  }
}

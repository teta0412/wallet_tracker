import 'package:flutter/material.dart';

class Expense {
  final String title;
  final double amount;

  Expense(this.title, this.amount);
}

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final List<Expense> _expenses = [];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Expense Tracker'),
        // ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _titleController,

                  ),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (ctx,index){
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('\$${_expenses[index].amount.toStringAsFixed(2)}'),
                        ),
                        title: Text(_expenses[index].title),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
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
            onPressed: addExpense,
            child: const Icon(Icons.add)
        ),
      ),
    );
  }
}

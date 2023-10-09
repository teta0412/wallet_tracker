import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallet_tracker/expense_tracker.dart';
import 'package:wallet_tracker/payments.dart';
import 'package:wallet_tracker/report.dart';
import 'package:wallet_tracker/settings.dart';
import 'theme/colors.dart';
import 'components/transaction.dart';
import 'components/adding_box.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const ExpenseTrackerApp(),
    const Report(),
    const Payments(),
    const Settings(),
  ];

  List<IconData> iconList = [
    Icons.account_balance_wallet,
    Icons.bar_chart,
    Icons.payments,
    Icons.settings
  ];
  List<Transaction> transactions = [];
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


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey.shade600,
            onPressed: createBoxExpense,
            child: const Icon(Icons.add,size: 25,),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: _selectedIndex,
            activeColor: primary,
            splashColor: secondary,
            inactiveColor: Colors.black.withOpacity(0.5),
            gapLocation: GapLocation.center,
            leftCornerRadius: 0,
            iconSize: 25,
            rightCornerRadius: 0,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: _onItemTapped,
          ),
        ),
      );
    }
}

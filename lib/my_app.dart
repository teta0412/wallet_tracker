import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_tracker/data/transaction_data.dart';
import 'package:wallet_tracker/homepage.dart';
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
  List<Transaction> transactions =[];
  static final List<Widget> _widgetOptions = <Widget>[
    const Homepage(),
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
  final TextEditingController  _transactionNameController = TextEditingController();
  final TextEditingController _transactionAmountController = TextEditingController();
  String _transactionStatusController ='';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<TransData>(
      builder: (context , value , child) => Scaffold(
              body: Center(
                child:_widgetOptions.elementAt(_selectedIndex),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.grey.shade500,
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AddingBox(
                          title: _transactionNameController,
                          amount: _transactionAmountController,
                          onSave: (){
                            final title = _transactionNameController.text;
                            final amount = int.parse(_transactionAmountController.text);
                            final status = _transactionStatusController;
                            final trans = context.read<TransData>();
                            if (title.isNotEmpty && amount > 0){
                                trans.addNewTrans(Transaction(transactionName: title, money: amount, expenseOrIncome: status));
                                _transactionNameController.clear();
                                _transactionAmountController.clear();
                            }
                            Navigator.of(context).pop();
                          },
                          onCancel: (){
                            _transactionNameController.clear();
                            _transactionAmountController.clear();
                            Navigator.of(context).pop();
                          },
                          expenseOrIncome:(selectedCategory){
                            _transactionStatusController = selectedCategory;
                          },
                        );
                      }
                  );
                },
                child: const Icon(Icons.add,size: 25),
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

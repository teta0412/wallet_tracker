import 'package:flutter/material.dart';
import 'package:wallet_tracker/expense_tracker.dart';
import 'package:wallet_tracker/payments.dart';
import 'package:wallet_tracker/report.dart';
import 'package:wallet_tracker/settings.dart';

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
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("My App"),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.notifications))
            ],
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payments),
                label: 'Budget',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings'
              ),
            ],
            currentIndex: _selectedIndex,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.cyanAccent,
            unselectedItemColor: Colors.grey ,
            onTap: _onItemTapped,
          ),
        ),
      );
    }
}

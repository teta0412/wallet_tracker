import 'package:flutter/material.dart';
import 'package:wallet_tracker/currency_converter.dart';
import 'package:wallet_tracker/expense_tracker.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My App"),
            titleTextStyle:const TextStyle(fontStyle: FontStyle.italic),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.search))
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.wallet)),
                Tab(icon: Icon(Icons.currency_exchange))
              ],
            ),
          ),
          body: TabBarView(
              children: [
                ExpenseTrackerApp(),
                CurrencyConverterApp(),
              ]
          ),
          drawer: Drawer(
            child: ListView(
              children:[
                const UserAccountsDrawerHeader(
                    accountName:Text("Nguyen Anh Duc") ,
                    accountEmail:Text("ducna0412@gmail.com"),
                    currentAccountPicture: CircleAvatar(),
                ),
                ListTile(
                  title: Text("Wallet"),
                  leading: Icon(Icons.wallet),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Converter"),
                  leading: Icon(Icons.currency_exchange),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Setting"),
                  leading: Icon(Icons.settings),
                  onTap: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
    }
  }

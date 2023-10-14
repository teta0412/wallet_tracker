import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_tracker/components/top_card.dart';
import 'package:wallet_tracker/data/transaction_data.dart';
import 'components/transaction.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TransData>(
      builder: (context , value , child) => Scaffold(
          body: Column(
            children: <Widget>[
              TopCard(
                balance: context.read<TransData>().totalBalance(),
                income: context.read<TransData>().totalIncome(),
                expense: context.read<TransData>().totalExpense(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: context.read<TransData>().allTransList.length,
                      itemBuilder: (ctx,index) {
                        return Transaction(
                          transactionName: context.read<TransData>().allTransList[index].transactionName,
                          money: context.read<TransData>().allTransList[index].money,
                          expenseOrIncome: context.read<TransData>().allTransList[index].expenseOrIncome,
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
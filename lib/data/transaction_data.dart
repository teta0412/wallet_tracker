import 'package:flutter/material.dart';
import 'package:wallet_tracker/components/transaction.dart';

class TransData extends ChangeNotifier {
  List<Transaction> allTransList = [];

  List<Transaction> getAllTransList() {
    return allTransList;
  }

  String totalIncome(){
    double balance =0;
    for (var i = 0; i < allTransList.length ; i++ ){
      if (allTransList[i].expenseOrIncome == 'income')
      {
        balance += allTransList[i].money;
      }
    }
    return balance.toStringAsFixed(2);
  }

  String totalExpense(){
    double balance =0;
    for (var i = 0; i < allTransList.length ; i++ ){
      if (allTransList[i].expenseOrIncome == 'expense')
      {
        balance += allTransList[i].money;
      }
    }
    return balance.toStringAsFixed(2);
  }

  String totalBalance(){
    double income =0 , expense =0 ,balance =0;
    for (var i = 0; i < allTransList.length ; i++ ){
      if (allTransList[i].expenseOrIncome == 'income')
      {
        income += allTransList[i].money;
      }
    }
    for (var i = 0; i < allTransList.length ; i++ ){
      if (allTransList[i].expenseOrIncome == 'expense')
      {
        expense += allTransList[i].money;
      }
    }
    balance = income -expense;
    return balance.toStringAsFixed(2);
  }
  void addNewTrans (Transaction newTrans){
    allTransList.add(newTrans);
    notifyListeners();
  }
  void deleteExpense(Transaction trans) {
    allTransList.remove(trans);
    notifyListeners();
  }

}
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
    return balance.toString();
  }

  String totalExpense(){
    double balance =0;
    for (var i = 0; i < allTransList.length ; i++ ){
      if (allTransList[i].expenseOrIncome == 'expense')
      {
        balance += allTransList[i].money;
      }
    }
    return balance.toString();
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
    return balance.toString();
  }
  void addNewTrans (Transaction newTrans){
    allTransList.add(newTrans);
    notifyListeners();
  }
  void deleteTrans(Transaction trans) {
    allTransList.remove(trans);
    notifyListeners();
  }
  void deleteAllTrans(){
    allTransList.removeRange(0, allTransList.length);
    notifyListeners();
  }

}
import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final String transactionName;
  final int money;
  final String expenseOrIncome;

  const Transaction({super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding:const EdgeInsets.all(15),
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[600],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(transactionName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      )),
                ],
              ),
              Text(
                '${expenseOrIncome == 'expense' ? '-' : '+'}\$$money',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                  expenseOrIncome == 'expense' ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

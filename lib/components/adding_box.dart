import 'package:flutter/material.dart';

class AddingBox extends StatefulWidget {
  final title;
  final amount;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Function(String) expenseOrIncome;

   AddingBox({
    super.key,
    required this.title,
    required this.amount,
    required this.onSave,
    required this.onCancel, required this.expenseOrIncome,
  });

  @override
  State<AddingBox> createState() => _AddingBoxState();
}


class _AddingBoxState extends State<AddingBox> {
  String selectedCategory = '' ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey.shade800,
      title: const Center(child: Text('N E W  T R A N S A C T I O N',style: TextStyle(fontWeight: FontWeight.bold),)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22))
      ),
      content: Container(
        height: 200,
        width: 200,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextField(
              controller: widget.title,
              style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Transaction'
              ),
            ),
            TextField(
              controller: widget.amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Amount'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 5.0),
                Wrap(
                  spacing: 5.0,
                  children: <Widget>[
                  ChoiceChip(
                    label:const Text('Expense', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blueGrey,
                    surfaceTintColor: Colors.deepPurpleAccent,
                    selectedColor: Colors.lightBlueAccent,
                    selected: selectedCategory == 'Expense',
                    onSelected: (isSelected) {
                      setState(() {
                          selectedCategory = 'expense';
                          widget.expenseOrIncome(selectedCategory);
                      });
                    },
                  ),
                    ChoiceChip(
                      label:const  Text('Income', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.blueGrey,
                      surfaceTintColor: Colors.deepPurpleAccent,
                      selectedColor: Colors.lightBlueAccent,
                      selected: selectedCategory == 'Income',
                      onSelected: (isSelected) {
                        setState(() {
                            selectedCategory = 'income';
                            widget.expenseOrIncome(selectedCategory);
                        });
                      },
                    )
                  ]
                ),
              ],
            )
          ],
        ),
      ),

      actions: [
        MaterialButton(
          onPressed: widget.onSave,
          color: Colors.blueGrey.shade300,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: widget.onCancel,
          color: Colors.blueGrey.shade300,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

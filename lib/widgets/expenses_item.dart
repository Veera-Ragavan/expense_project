import 'package:expense_app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense,{super.key,});

final Expense expense;


  @override
  Widget build(BuildContext context) {
    return Card(
     child: Padding(
       padding: EdgeInsets.all(16.0),
       child: Column(
         children: [
           Row(
             children: [
               Text(expense.title,
               style: TextStyle(
                fontSize: 30,
               ), 
               ),
             ],
           ),
           SizedBox(height: 10),
           Row(
             children: [
               Text('\$${expense.amount.toStringAsFixed(2)}'),
               Spacer(),
               Row(
                 children: [
              Icon(categoryIcons[expense.category]),
              SizedBox(width: 8),
              Text(expense.formattedDate),
                 ],
               ),
             ],
           ),
         ],
       ),
     ),
          ); 
  }
}
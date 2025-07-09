import 'package:expense_app/model/expense.dart';
import 'package:expense_app/model/newexpenses.dart';
import 'package:expense_app/widgets/expenses_item.dart';
import 'package:flutter/material.dart';


class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses,required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
       onDismissed: (direction){
        onRemoveExpense(expenses[index]);
       },
        child:  ExpensesItem(expenses[index]),),
      
      );
  }
}
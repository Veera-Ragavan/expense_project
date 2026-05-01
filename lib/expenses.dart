
import 'package:expense_app/model/expense.dart';
import 'package:expense_app/model/newexpenses.dart';
import 'package:expense_app/widgets/expenses_item.dart';
import 'package:expense_app/widgets/expenses_list.dart';
import 'package:expense_app/chart/chart.dart';
import 'package:flutter/material.dart';


class Expenses extends StatefulWidget {
   Expenses({super.key});


  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
   final List<Expense> _registeredexpenses = [
    Expense(
      title: 'flutter',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),

    Expense(
      title: 'cinema',
      amount: 39.99,
      date: DateTime.now(),
      category: Category.leisure
    ),

  ];



void openaddexpenseoverlay() {
  showModalBottomSheet(
    context: context,
    // Add this
    builder: (ctx) => Newexpenses(onAddExpense: _addExpense),
  );
}


void _addExpense(Expense expense){
  setState(() {
    _registeredexpenses.add(expense);
  });
}

void _RemoveExpense(Expense expense){
  final expenseIndex = _registeredexpenses.indexOf(expense);
  setState((){
    _registeredexpenses.remove(expense);
  });
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      content: Text('Expense Deleted'),
    action: SnackBarAction(
      label: 'undo', 
      onPressed: (){
        setState(() {
          _registeredexpenses.insert(expenseIndex, expense);
        });
      }
      ),
    ),
    );
}


  @override
  Widget build(BuildContext context) {
Widget mainContent = Center(
  child: Text('no expense found')
  );
  if(_registeredexpenses.isNotEmpty){
    mainContent = ExpensesList(expenses: _registeredexpenses,onRemoveExpense: _RemoveExpense);
  };
  final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter Expense tracker',style: TextStyle(
          fontWeight: FontWeight.bold,
        )),
        actions: [
          IconButton(
            onPressed: openaddexpenseoverlay, 
            icon: Icon(Icons.add),
            ),
        ],
      ),
      backgroundColor: Colors.purple[300],
      body:width>600 ? Column(
        children: [
          chartpage(expenses: _registeredexpenses),
          Expanded(child: mainContent),
        ],
        ):
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
            Expanded(child: chartpage(expenses: _registeredexpenses)),
          Expanded(child: mainContent),
          ],
        ),
    );
  }
}


import 'package:expense_app/expenses.dart';
import 'package:expense_app/model/expense.dart';
import 'package:expense_app/widgets/expenses_item.dart';
import 'package:flutter/material.dart';

class Newexpenses extends StatefulWidget {
Newexpenses({super.key,required this.onAddExpense});

final void Function(Expense) onAddExpense;


  @override
  State<Newexpenses> createState() => _NewexpensesState();
}

class _NewexpensesState extends State<Newexpenses> {
final  titlecontroller = TextEditingController();
final  amountcontroller = TextEditingController();
DateTime? _selectedDate;
 Category _selectedcategory = Category.leisure;


final now = DateTime.now();


@override
  void dispose() {
    titlecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

void presentDatepicker() async{

final firstdate = DateTime(DateTime.now().year-1,DateTime.now().month, DateTime.now().day);

  final pickedDate = await showDatePicker(
    context: context, 
    initialDate: now,
    firstDate: firstdate, 
    lastDate: now,
    );

    setState(() {
    _selectedDate = pickedDate;
    });
}

void _saveExpenses(){
   
   final enterAmount = double.tryParse(amountcontroller.text);
   final amountIsinvaild = enterAmount == null || enterAmount <= 0;
   if(titlecontroller.text.trim().isEmpty || amountIsinvaild || _selectedDate == null){
    showDialog(
      context: context, 
      builder: (context){
        return AboutDialog(
          children: [
            Text('inVaild please enter expenses'),
          ],
        );
      }
    );
   }
   widget.onAddExpense(
    Expense(
      title: titlecontroller.text, 
      amount: enterAmount!, 
      date: _selectedDate!, 
      category: _selectedcategory,
      ),
   );
   Navigator.pop(context);
}


  @override
 
  Widget build(BuildContext context) {
     final keyboard = MediaQuery.of(context).viewInsets.bottom;
     return LayoutBuilder(builder: (context, constraints){
      final width = constraints.maxWidth;
       return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16,16,16,keyboard + 16.0),
        
        child: Column(
          children: [
            if(width<=600)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
Expanded(
  child: TextField(
                controller: titlecontroller,
                maxLength: 50,
                decoration: InputDecoration(
                  label: Text('title'),
                  
                ),
              ),
),
SizedBox(width: 24),
      
            Expanded(
              child: TextField(
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Amount'),
                  
                ),
              ),
            ),
            ])
            else
            TextField(
              controller: titlecontroller,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text('title'),
                
              ),
            ),
      if(width<=600)
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
       value: _selectedcategory,
        items: Category.values.map(
          (Category) => DropdownMenuItem(
            value: Category,
            child: Text(Category.name.toString()),
            ),
        ).toList(),
        onChanged: (value){
          if (value == null) {
            return;
          }
          setState(() {
            _selectedcategory = value;
          });
        },
                  ),
                    Row(
                   children: [
                    Text(
                      _selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),
                    ),
                     IconButton(
                      onPressed: (){
                        presentDatepicker();
                      }, 
                      icon: Icon(Icons.calendar_month),
                      ),
                   ],
                 ),
      ])
      else
            TextField(
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text('Amount'),
                
              ),
            ),
            SizedBox(height: 20),
            if(width<=600)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                                     child: Text('Cancel'),),
                   
                 
                SizedBox(width: 16,),
                ElevatedButton(
                  onPressed: _saveExpenses,
                child: Text('Save expenses'),),
            ]
        )
            else
            Row(
              children: [
                DropdownButton(
       value: _selectedcategory,
        items: Category.values.map(
          (Category) => DropdownMenuItem(
            value: Category,
            child: Text(Category.name.toString()),
            ),
        ).toList(),
        onChanged: (value){
          if (value == null) {
            return;
          }
          setState(() {
            _selectedcategory = value;
          });
        },
                  ),
                  SizedBox(width: 24),
                 Row(
                   children: [
                    Text(
                      _selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),
                    ),
                     IconButton(
                      onPressed: (){
                        presentDatepicker();
                      }, 
                      icon: Icon(Icons.calendar_month),
                      ),
                   ],
                 ),
                  Spacer(),
                 Row(
                   children: [ 
                     ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                                     child: Text('Cancel'),),
                   ],
                 ),
                SizedBox(width: 16,),
                ElevatedButton(
                  onPressed: _saveExpenses,
                child: Text('Save expenses'),),
              ],
            ),
          ],
        ),
      ),
    );

     });
   
  }
}
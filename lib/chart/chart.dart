import 'package:expense_app/chart/chartbar.dart';
import 'package:expense_app/model/expense.dart';
import 'package:flutter/material.dart';

class chartpage extends StatelessWidget {
  const chartpage({super.key,required this.expenses});
 final List<Expense> expenses;

 List<Expensebucket> get buckets{
  return [
    Expensebucket.forCategory(expenses, Category.food),
    Expensebucket.forCategory(expenses, Category.leisure),
    Expensebucket.forCategory(expenses, Category.travel),
    Expensebucket.forCategory(expenses, Category.work),
  ];
 }

 double get maxTotalExpense {
  double maxTotalExpense = 0;
  for(final bucket in buckets){
if(bucket.totalexpense > maxTotalExpense){
  maxTotalExpense = bucket.totalexpense;
}
  }
  return maxTotalExpense;
 }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8),
gradient: LinearGradient(colors: [
  Theme.of(context).colorScheme.primary.withOpacity(0.3),
  Theme.of(context).colorScheme.primary.withOpacity(0.0)
],
begin: Alignment.bottomCenter,
end: Alignment.topCenter,
),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for(final bucket in buckets)
                chartbar(fill: bucket.totalexpense / maxTotalExpense,),
                
              ],
            ),
            ),
           SizedBox(height: 12),
            Row(
              children: buckets.map((bucket) => Expanded(
                child: Padding
                (padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
                child: Icon(
                  categoryIcons[bucket.category],
                ),
                ),
                ),
                ).toList(),
            ),
        ],
      ),
    );
  }
}

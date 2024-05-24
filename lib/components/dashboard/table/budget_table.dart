// budget_table.dart
import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';

class BudgetTable extends StatelessWidget {
  final List<Map<String, dynamic>> budgets;

  const BudgetTable({Key? key, required this.budgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Name', style: heading3),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Limit', style: heading3),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Spent', style: heading3),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Percent', style: heading3),
              ),
            ),
          ],
        ),
        ...budgets.map((budget) {
          final percentSpent = (budget['spent'] / budget['limit']) * 100;
          return TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(budget['name']),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(budget['limit'].toStringAsFixed(2)),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(budget['spent'].toStringAsFixed(2)),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${percentSpent.toStringAsFixed(2)}%'),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

// savings_table.dart
import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';

class SavingsTable extends StatelessWidget {
  final List<Map<String, dynamic>> savings;

  const SavingsTable({Key? key, required this.savings}) : super(key: key);

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
                child: Text('Goal', style: heading3),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Saved', style: heading3),
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
        ...savings.map((saving) {
          final percentSaved = (saving['saved'] / saving['goal']) * 100;
          return TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(saving['name']),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(saving['goal'].toStringAsFixed(2)),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(saving['saved'].toStringAsFixed(2)),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${percentSaved.toStringAsFixed(2)}%'),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';

class ExpensePieChart extends StatelessWidget {
  final List<Map<String, dynamic>> budgets;

  const ExpensePieChart({required this.budgets, super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: budgets.asMap().entries.map((entry) {
          final int index = entry.key;
          final Map<String, dynamic> budget = entry.value;
          final double spentPercentage = budget['spent'] / budget['limit'];
          return PieChartSectionData(
            value: spentPercentage,
            title: '${(spentPercentage * 100).toStringAsFixed(1)}%',
            color: colorList[index],
            titleStyle: heading4L,
            radius: 80
          );
        }).toList(),
        sectionsSpace: 2,
        centerSpaceRadius: medium,
      ),
    );
  }
}


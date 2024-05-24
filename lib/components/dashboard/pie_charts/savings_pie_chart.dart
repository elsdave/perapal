import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:perapal/utils/style.dart';

class SavingsBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> savings;

  const SavingsBarChart({required this.savings, super.key});

  Widget getTitles(double value, TitleMeta meta) {
    final style = p1;
    String text;
    if (value >= 0 && value < savings.length) {
      text = savings[value.toInt()]['name'];
    } else {
      text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: savings.asMap().entries.map((entry) {
          final int index = entry.key;
          final Map<String, dynamic> saving = entry.value;
          return BarChartGroupData(
            barsSpace: 2,
            x: index,
            barRods: [
              BarChartRodData(
                toY: saving['saved'],
                color: Colors.grey[500],
                width: xsmall,
              ),
              BarChartRodData(
                toY: saving['goal'],
                color: colorList[index],
                width: xsmall,
              ),
            ],
          );
        }).toList(),
        alignment: BarChartAlignment.spaceEvenly,
        barTouchData: BarTouchData(enabled: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: getTitles,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
      ),
    );
  }
}
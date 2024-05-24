import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';

class BudgetBox extends StatelessWidget {
  final String budgetName;
  final num budgetLimit;
  final num amountSpent;

  const BudgetBox({
    super.key,
    required this.budgetName,
    required this.budgetLimit,
    required this.amountSpent,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the amount remaining
    num amountRemaining = budgetLimit - amountSpent;

    // Calculate the percentage of budget spent
    double percentageSpent = amountSpent / budgetLimit;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: blue,
      ),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            budgetName,
            style: heading1L.copyWith(fontSize: 25),
          ),

          const SizedBox(height: 5.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Limit: \₱ ${budgetLimit.toStringAsFixed(2)}',
                style: heading3L,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spent: \₱ ${amountSpent.toStringAsFixed(2)}',
                style: heading3L,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining: \₱ ${amountRemaining.toStringAsFixed(2)}',
                style: heading3L,
              ),
            ],
          ),

          // Progress Bar
          const SizedBox(height: 10.0),
          LinearProgressIndicator(
            value: percentageSpent,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}

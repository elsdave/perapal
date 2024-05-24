import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';

class SavingsBox extends StatelessWidget {
  final String goalName;
  final double goalAmount;
  final double savedAmount;

  const SavingsBox({
    super.key,
    required this.goalName,
    required this.goalAmount,
    required this.savedAmount,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the amount remaining
    double remainingAmount = goalAmount - savedAmount;

    // Calculate the percentage of goal achieved
    double percentageAchieved = savedAmount / goalAmount;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: yellow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goalName,
            style: heading1D.copyWith(
              fontSize: 25,),
          ),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Goal: \₱ ${goalAmount.toStringAsFixed(2)}',
                style: heading3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saved: \₱ ${savedAmount.toStringAsFixed(2)}',
                style: heading3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining: \₱ ${remainingAmount.toStringAsFixed(2)}',
                style: heading3,
              ),
            ],
          ),
          // Progress Bar
          const SizedBox(height: 10.0),
          LinearProgressIndicator(
            value: percentageAchieved.toDouble(),
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:perapal/components/cash_display.dart';
import 'package:perapal/components/savings/savings_box.dart';
import 'package:perapal/utils/style.dart';
import 'package:perapal/components/dialogs.dart';
import 'package:perapal/components/modify_budget_savings_box.dart';
import 'package:perapal/components/button.dart';
import 'package:perapal/firebase/interactions.dart';

class Savings extends StatefulWidget {
  const Savings({super.key});

  @override
  _SavingsState createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  // List of savings goals
  List<Map<String, dynamic>> savingsGoals = [];

  String _sortCriteria = 'name';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    fetchSavingsGoals();
  }

  Future<void> fetchSavingsGoals() async {
    final List<Map<String, dynamic>> fetchedSavingsGoals = await uidSavings();
    setState(() {
      savingsGoals = fetchedSavingsGoals.map((saving) => {
        'name': saving['name'],
        'goal': (saving['goal'] as num).toDouble(),
        'saved': (saving['saved'] as num).toDouble(),
      }).toList();
      _sortSavingsGoals(); // Sort initially after fetching
    });
  }

  double get totalSavedAmount =>
      savingsGoals.fold(0, (prev, goal) => prev + (goal['saved'] as num).toDouble());

  void _sortSavingsGoals() {
    setState(() {
      savingsGoals.sort((a, b) {
        int comparison;
        switch (_sortCriteria) {
          case 'name':
            comparison = a['name'].compareTo(b['name']);
            break;
          case 'goal':
            comparison = a['goal'].compareTo(b['goal']);
            break;
          case 'saved':
            comparison = a['saved'].compareTo(b['saved']);
            break;
          default:
            comparison = 0;
        }
        return _isAscending ? comparison : -comparison;
      });
    });
  }

  void _addSavingsGoal(String name, double goalAmount, double savedAmount) {
    setState(() {
      savingsGoals.add({
        'name': name,
        'goal': goalAmount,
        'saved': savedAmount,
      });
      _sortSavingsGoals(); // Sort after adding new savings goal
    });
  }

  void _modifySavingsGoal(int index, double newGoalAmount, double newSavedAmount) {
    setState(() {
      savingsGoals[index]['goal'] = newGoalAmount;
      savingsGoals[index]['saved'] = newSavedAmount;
      modifySavings(savingsGoals[index]['name'], newGoalAmount, newSavedAmount);
      _sortSavingsGoals(); // Sort after modifying savings goal
    });
  }

  void _deleteSavingsGoal(int index) async {
    String goalName = savingsGoals[index]['name'];
    await deleteSavingsGoal(goalName);
    setState(() {
      savingsGoals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Savings",
          style: heading1D,
          selectionColor: textLight,
        ),
        elevation: 0,
        backgroundColor: yellow,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),

              CashDisplay(
                expenseName: "Total Savings",
                cashValue: totalSavedAmount,
                color: yellow,
                style: heading1D,
              ),

             SizedBox(height: medium),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Savings Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: _sortCriteria,
                        onChanged: (String? newValue) {
                          setState(() {
                            _sortCriteria = newValue!;
                            _sortSavingsGoals();
                          });
                        },
                        items: <String>['name', 'goal', 'saved']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value[0].toUpperCase() + value.substring(1)),
                          );
                        }).toList(),
                      ),
                      IconButton(
                        icon: Icon(
                          _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                        ),
                        onPressed: () {
                          setState(() {
                            _isAscending = !_isAscending;
                            _sortSavingsGoals();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Iterate over the list and create SavingsBox for each item
              for (var i = 0; i < savingsGoals.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => showModifySavingsDialog(
                            context,
                            savingsGoals[i]['name'],
                            savingsGoals[i]['goal'],
                            savingsGoals[i]['saved'],
                            (newGoalAmount, newSavedAmount) => _modifySavingsGoal(i, newGoalAmount, newSavedAmount),
                          ),
                          child: SavingsBox(
                            goalName: savingsGoals[i]['name'],
                            goalAmount: savingsGoals[i]['goal'],
                            savedAmount: savingsGoals[i]['saved'],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteSavingsGoal(i),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20.0),
/* 

              Button(
                onPressed: () => showAddSavingsDialog(context, _addSavingsGoal),
                buttonText: 'Add New Savings',
              ),

 */

            ],
          ),
        ),
      ),
    );
  }
}

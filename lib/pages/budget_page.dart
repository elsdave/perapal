import 'package:flutter/material.dart';
import 'package:perapal/components/button.dart';
import 'package:perapal/utils/style.dart';
import 'package:perapal/components/budget/budget_box.dart';
import 'package:perapal/components/cash_display.dart';
import 'package:perapal/firebase/interactions.dart';
import 'package:perapal/components/dialogs.dart'; 

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  List<Map<String, dynamic>> budgets = [];
  String _sortCriteria = 'name';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    fetchBudget();
  }

  Future<void> fetchBudget() async {
    final List<Map<String, dynamic>> fetchedBudgets = await uidBudget();
    setState(() {
      budgets = fetchedBudgets.map((budget) => {
        'name': budget['name'],
        'limit': (budget['limit'] as num).toDouble(),
        'spent': (budget['spent'] as num).toDouble(),
      }).toList();
      _sortBudgets(); // Sort initially after fetching
    });
  }

  void _sortBudgets() {
    setState(() {
      budgets.sort((a, b) {
        int comparison;
        switch (_sortCriteria) {
          case 'name':
            comparison = a['name'].compareTo(b['name']);
            break;
          case 'limit':
            comparison = a['limit'].compareTo(b['limit']);
            break;
          case 'spent':
            comparison = a['spent'].compareTo(b['spent']);
            break;
          default:
            comparison = 0;
        }
        return _isAscending ? comparison : -comparison;
      });
    });
  }

  double get totalBudget => budgets.fold(0, (prev, budget) => prev + (budget['limit'] as num).toDouble());
  double get totalSpent => budgets.fold(0, (prev, budget) => prev + (budget['spent'] as num).toDouble());
  double get totalRemaining => totalBudget - totalSpent;

  void _addBudget(String name, double limit, double spent) {
    setState(() {
      budgets.add({
        'name': name,
        'limit': limit,
        'spent': spent,
      });
      _sortBudgets(); // Sort after adding new budget
    });
  }

  void _deleteBudget(int index) async {
    String budgetName = budgets[index]['name'];
    await deleteBudget(budgetName);
    setState(() {
      budgets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Budgeting",
          style: heading1L,
          selectionColor: textDark,
        ),
        elevation: 0,
        backgroundColor: blue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),

            Row(
              // Display Total widgets side by side
              children: [
                Expanded(
                  child: CashDisplay(expenseName: "Total Budget", cashValue: totalBudget, color: blue, style: heading1L),
                ),
                const SizedBox(width: 10), // Add space between widgets
                Expanded(
                  child: CashDisplay(expenseName: "Total Remaining", cashValue: totalRemaining, color: blue, style: heading1L),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Budget Overview',
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
                          _sortBudgets();
                        });
                      },
                      items: <String>['name', 'limit', 'spent']
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
                          fetchBudget();
                          _isAscending = !_isAscending;
                          _sortBudgets();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            // Iterate over the list and create BudgetBox for each item
            for (var i = 0; i < budgets.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: BudgetBox(
                        budgetName: budgets[i]['name'],
                        budgetLimit: budgets[i]['limit'],
                        amountSpent: budgets[i]['spent'],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteBudget(i),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),
              
/* 
              Button(
                onPressed: () => showAddBudgetDialog(context, _addBudget),
                buttonText: 'Add New Budget',
              ),

 */

          ],
        ),
      ),
    );
  }
}

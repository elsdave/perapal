import 'package:flutter/material.dart';
import 'package:perapal/components/cash_display.dart';
import 'package:perapal/utils/style.dart';
import 'package:perapal/components/button.dart';
import 'package:perapal/firebase/interactions.dart';
import 'package:perapal/components/dialogs.dart'; // Import the new dialog file

class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<Expense> {
  List<Map<String, dynamic>> expenses = [];
  String _sortCriteria = 'date';
  bool _isAscending = false;

  @override
  void initState() {
    super.initState();
    fetchExpensesList();
  }

  Future<void> fetchExpensesList() async {
    final List<Map<String, dynamic>> fetchedExpenses = await fetchExpenses();
    setState(() {
      expenses = fetchedExpenses;
    });
  }

  void _addExpense(String budgetName, double amount, String notes, DateTime date) async {
    await addExpense(budgetName, amount, notes, date);
    fetchExpensesList();
  }

  void _deleteExpense(String expenseId) async {
    await deleteExpense(expenseId);
    fetchExpensesList();
  }

  void _sortExpenses() {
    setState(() {
      expenses.sort((a, b) {
        int comparison;
        switch (_sortCriteria) {
          case 'budgetName':
            comparison = a['budgetName'].compareTo(b['budgetName']);
            break;
          case 'amount':
            comparison = a['amount'].compareTo(b['amount']);
            break;
          default:
            // By default, sort by date
            comparison = a['date'].compareTo(b['date']);
        }
        return _isAscending ? comparison : -comparison;
      });
    });
  }

  double get totalExpense => expenses.fold(0, (prev, budget) => prev + (budget['amount'] as num).toDouble());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Expenses",
          style: heading1L,
          selectionColor: textDark,
        ),
        elevation: 0,
        backgroundColor: red,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),

            CashDisplay(
              expenseName: "Total Expenses",
              cashValue: totalExpense,
              color: red,
              style: heading1L,
            ),

            SizedBox(height: medium),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Expense Overview',
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
                          _sortExpenses();
                        });
                      },
                      items: <String>['date', 'budgetName', 'amount']
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
                          _sortExpenses();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            for (var i = 0; i < expenses.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(expenses[i]['budgetName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount: \₱ ${expenses[i]['amount']}'),
                            Text('Notes: ${expenses[i]['notes']}'),
                            Text('Date: ${expenses[i]['date']}'),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteExpense(expenses[i]['id']),
                    ),
                  ],
                ),
              ),
/* 
            Button(
              onPressed: () => showAddExpenseDialog(context, _addExpense),
              buttonText: 'Add New Expense',
            ),

 */            
          ],
        ),
      ),
    );
  }
}

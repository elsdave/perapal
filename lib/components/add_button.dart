import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';
import 'package:perapal/components/dialogs.dart'; // Import the dialogs.dart file
import 'package:perapal/firebase/interactions.dart'; // Import the interactions.dart file to add expense

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: white,
      backgroundColor: blue,
      shape: StadiumBorder(
        side: BorderSide(
          color: textLight,
          width: 4,
        ),
      ),
      onPressed: () => _dialogBuilder(context), // Call the function to show the dialog
      child: Icon(
        Icons.add,
        size: medium,
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Add transactions",
              style: heading3,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Expenses",
                  style: p2,
                ),
                Text(
                  "Budgets",
                  style: p2,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    await showAddExpenseDialog(context, (String budgetName, double amount, String notes, DateTime date) async {
                      await addExpense(budgetName, amount, notes, date);
                    });
                  },
                  child: const Icon(Icons.money),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    Navigator.pop(context); 
                    await showAddBudgetDialog(context, (String name, double limit, double spent) async {
                      await addBudget(name, limit, spent);
                    });
                  },
                  child: const Icon(Icons.wallet),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Savings",
                style: p2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await showAddSavingsDialog(context, (String name, double goal, double saved) async {
                      await addSavingsGoal(name, goal, saved);
                    });
                  },
                  child: const Icon(Icons.savings),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

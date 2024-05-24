import 'package:flutter/material.dart';
import 'package:perapal/firebase/interactions.dart';
Future<void> showAddBudgetDialog(
  BuildContext context,
  Function(String, double, double) onAdd,
) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController limitController = TextEditingController();
  final TextEditingController spentController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Budget'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Budget Name'),
              ),
              TextField(
                controller: limitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Budget Limit'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () async {
              final String name = nameController.text;
              final double limit = double.tryParse(limitController.text) ?? 0;
              final double spent = double.tryParse(spentController.text) ?? 0;

              if (name.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Invalid Budget Name'),
                      content: const Text('Please enter a valid budget name.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else if (limit < 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Invalid Amount'),
                      content: const Text('Please enter a valid amount (at least P1).'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                onAdd(name, limit, spent);
                await addBudget(name, limit, spent); // Add the budget to Firestore
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showAddSavingsDialog(
  BuildContext context,
  Function(String, double, double) onAdd,
) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController goalController = TextEditingController();
  final TextEditingController savedController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Savings Goal'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Goal Name'),
              ),
              TextField(
                controller: goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Goal Amount'),
              ),
              TextField(
                controller: savedController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount Saved'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () async {
              final String name = nameController.text;
              final double goal = double.tryParse(goalController.text) ?? 0;
              final double saved = double.tryParse(savedController.text) ?? 0;

              if (name.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Invalid Savings Name'),
                      content: const Text('Please enter a valid savings name.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else if (goal < 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Invalid Amount'),
                      content: const Text('Please enter a valid amount (at least P1) for the goal.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                onAdd(name, goal, saved);
                await addSavingsGoal(name, goal, saved);  // Add the savings goal to Firestore
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showAddExpenseDialog(BuildContext context, Function(String, double, String, DateTime) addExpenseCallback) async {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  List<Map<String, dynamic>> budgets = []; // Variable to store fetched budgets

  // Fetch the budget names from Firestore
  await uidBudget().then((value) {
    budgets = value;
  });

  // If no budgets are fetched, display an error message and return
  if (budgets.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No budgets found'),
          content: const Text('Please create a budget first.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  // Variable to store the selected budget name
  String selectedBudgetName = budgets[0]['name'];

  // Variable to store the selected date
  DateTime selectedDate = DateTime.now();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Expense'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              DropdownButtonFormField(
                value: selectedBudgetName,
                items: budgets.map((budget) {
                  return DropdownMenuItem(
                    value: budget['name'],
                    child: Text(budget['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedBudgetName = value.toString();
                },
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(hintText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(hintText: 'Notes'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(hintText: 'Date (optional, default is today)'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                    dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                  }
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              final double amount = double.tryParse(amountController.text) ?? 0;
              final String notes = notesController.text;

              if (amount < 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Invalid amount'),
                      content: const Text('Please enter an amount of at least \$1.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                addExpenseCallback(selectedBudgetName, amount, notes, selectedDate);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

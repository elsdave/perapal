import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:perapal/firebase/components/parse.dart';

Future<void> addDefaultData() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  try {
    await users.doc(uid).set({
      'budgets': [
        {
          'name': 'Sample',
          'limit': 500,
          'spent': 0,
        }
      ],
      'savings': [
        {
          'name': 'Sample',
          'goal': 500,
          'saved': 0,
        }
      ]
    }, SetOptions(merge: true)); // Merge to keep existing data
  } catch (e) {
    if (kDebugMode) {
      print('Error adding default data: $e');
    }
  }
}


Future<List<Map<String, dynamic>>> uidBudget() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) { 
      print('No user is currently signed in.');
    }
    return [];
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('budgets')) {
        return parseBudgets(data['budgets']);
      } else {
        if (kDebugMode) {
          print('No budget data found for the current user.');
        }
        return [];
      }
    } else {
      if (kDebugMode) {
        print('No data found for the current user.');
      }
      return [];
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching budget data: $e');
    }
    return [];
  }
}


Future<List<Map<String, dynamic>>> uidSavings() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return [];
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('savings')) {
        return (data['savings'] as List<dynamic>)
            .map((item) => {
              'name': item['name'],
              'goal': item['goal'],
              'saved': item['saved'],
            })
            .toList();
      } else {
        if (kDebugMode) {
          print('No savings data found for the current user.');
        }
        return [];
      }
    } else {
      if (kDebugMode) {
        print('No data found for the current user.');
      }
      return [];
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching savings data: $e');
    }
    return [];
  }
}

Future<void> addBudget(String name, double limit, double spent) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    await userDoc.update({
      'budgets': FieldValue.arrayUnion([
        {
          'name': name,
          'limit': limit,
          'spent': spent,
        }
      ])
    });
    if (kDebugMode) {
      print('Budget added successfully.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error adding budget: $e');
    }
  }
}

Future<void> addSavingsGoal(String name, double goal, double saved) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    await userDoc.update({
      'savings': FieldValue.arrayUnion([
        {
          'name': name,
          'goal': goal,
          'saved': saved,
        }
      ])
    });
    if (kDebugMode) {
      print('Savings goal added successfully.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error adding savings goal: $e');
    }
  }
}

Future<void> deleteBudget(String budgetName) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    // Fetch the user's document
    DocumentSnapshot snapshot = await userDoc.get();
    List<dynamic> budgets = snapshot['budgets'];

    // Find the budget to remove
    var budgetToRemove = budgets.firstWhere((budget) => budget['name'] == budgetName, orElse: () => null);

    if (budgetToRemove != null) {
      // Remove the budget from the list
      budgets.remove(budgetToRemove);

      // Update the document with the modified budget list
      await userDoc.update({'budgets': budgets});

      if (kDebugMode) {
        print('Budget deleted successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Budget not found.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error deleting budget: $e');
    }
  }
}

Future<void> deleteSavingsGoal(String goalName) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    // Fetch the user's document
    DocumentSnapshot snapshot = await userDoc.get();
    List<dynamic> savingsGoals = snapshot['savings'];

    // Find the savings goal to remove
    var goalToRemove = savingsGoals.firstWhere((goal) => goal['name'] == goalName, orElse: () => null);

    if (goalToRemove != null) {
      // Remove the savings goal from the list
      savingsGoals.remove(goalToRemove);

      // Update the document with the modified savings goals list
      await userDoc.update({'savings': savingsGoals});

      if (kDebugMode) {
        print('Savings goal deleted successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Savings goal not found.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error deleting savings goal: $e');
    }
  }
}

Future<void> modifySavings(String savingName, double newGoal, double newSaved) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    // Fetch the user's document
    DocumentSnapshot snapshot = await userDoc.get();
    List<dynamic> budgets = snapshot['savings'];

    // Find the budget to modify
    var savingsToModify = budgets.firstWhere((budget) => budget['name'] == savingName, orElse: () => null);

    if (savingsToModify != null) {
      // Update the budget values
      savingsToModify['goal'] = newGoal;
      savingsToModify['saved'] = newSaved;

      // Update the document with the modified budgets list
      await userDoc.update({'savings': budgets});

      if (kDebugMode) {
        print('Saving modified successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Saving not found.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error modifying savings: $e');
    }
  }
}

Future<void> addExpense(String budgetName, double amount, String notes, DateTime date) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    // Fetch the user's document
    DocumentSnapshot snapshot = await userDoc.get();
    List<dynamic> budgets = snapshot['budgets'];

    // Find the budget to modify
    var budgetToModify = budgets.firstWhere((budget) => budget['name'] == budgetName, orElse: () => null);

    if (budgetToModify != null) {
      // Update the spent amount
      budgetToModify['spent'] += amount;

      // Add the expense to the budget's expense list
      if (budgetToModify['expenses'] == null) {
        budgetToModify['expenses'] = [];
      }
      budgetToModify['expenses'].add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'amount': amount,
        'notes': notes,
        'date': date,
      });

      // Update the document with the modified budgets list
      await userDoc.update({'budgets': budgets});

      if (kDebugMode) {
        print('Expense added successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Budget not found.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error adding expense: $e');
    }
  }
}


Future<List<Map<String, dynamic>>> fetchExpenses() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return [];
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('budgets')) {
        List<Map<String, dynamic>> expenses = [];
        List<dynamic> budgets = data['budgets'];
        for (var budget in budgets) {
          if (budget.containsKey('expenses')) {
            for (var expense in budget['expenses']) {
              expenses.add({
                'budgetName': budget['name'],
                'id': expense['id'],
                'amount': expense['amount'],
                'notes': expense['notes'],
                'date': expense['date'].toDate(),
              });
            }
          }
        }
        return expenses;
      } else {
        if (kDebugMode) {
          print('No budget data found for the current user.');
        }
        return [];
      }
    } else {
      if (kDebugMode) {
        print('No data found for the current user.');
      }
      return [];
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching expenses: $e');
    }
    return [];
  }
}

Future<void> deleteExpense(String expenseId) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  if (uid == null) {
    if (kDebugMode) {
      print('No user is currently signed in.');
    }
    return;
  }

  final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    // Fetch the user's document
    DocumentSnapshot snapshot = await userDoc.get();
    List<dynamic> budgets = snapshot['budgets'];

    for (var budget in budgets) {
      var expenseToRemove = budget['expenses'].firstWhere((expense) => expense['id'] == expenseId, orElse: () => null);
      if (expenseToRemove != null) {
        budget['expenses'].remove(expenseToRemove);
        budget['spent'] -= expenseToRemove['amount'];
        await userDoc.update({'budgets': budgets});
        if (kDebugMode) {
          print('Expense deleted successfully.');
        }
        return;
      }
    }
    if (kDebugMode) {
      print('Expense not found.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error deleting expense: $e');
    }
  }
}


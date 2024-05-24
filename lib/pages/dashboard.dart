// dashboard.dart
import 'package:flutter/material.dart';
import 'package:perapal/components/dashboard/pie_charts/expense_pie.dart';
import 'package:perapal/utils/style.dart';
import 'package:perapal/firebase/interactions.dart';
import 'package:perapal/components/dashboard/pie_charts/budget_pie_chart.dart';
import 'package:perapal/components/dashboard/pie_charts/savings_pie_chart.dart';
import 'package:perapal/components/dashboard/table/budget_table.dart';
import 'package:perapal/components/dashboard/table/savings_table.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> budgets = [];
  List<Map<String, dynamic>> savings = [];
  List<Map<String, dynamic>> expenses = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchBudget();
    await fetchExpensesList();
    await fetchSavingsGoals();
  }

  Future<void> fetchBudget() async {
    final List<Map<String, dynamic>> fetchedBudgets = await uidBudget();
    setState(() {
      budgets = fetchedBudgets.map((budget) => {
        'name': budget['name'],
        'limit': (budget['limit'] as num).toDouble(),
        'spent': (budget['spent'] as num).toDouble(),
      }).toList();
    });
  }

  Future<void> fetchExpensesList() async {
    final List<Map<String, dynamic>> fetchedExpenses = await fetchExpenses();
    setState(() {
      expenses = fetchedExpenses.map((expense) => {
        'budgetName': expense['budgetName'],
        'amount': (expense['amount'] as num).toDouble(),
        'notes': expense['notes'],
        'date': expense['date'],
      }).toList();
    });
  }

  Future<void> fetchSavingsGoals() async {
    final List<Map<String, dynamic>> fetchedSavingsGoals = await uidSavings();
    setState(() {
      savings = fetchedSavingsGoals.map((saving) => {
        'name': saving['name'],
        'goal': (saving['goal'] as num).toDouble(),
        'saved': (saving['saved'] as num).toDouble(),
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: heading1L,
          selectionColor: textDark,
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Budgets Summary', style: heading2D),
                SizedBox(height: large),
                Center(
                  child: SizedBox(
                    height: 200,
                    child: BudgetPieChart(budgets: budgets),
                  ),
                ),
                SizedBox(height: medium),
                BudgetTable(budgets: budgets),
                
                SizedBox(height: medium),

                Text('Expenses Summary', style: heading2D),
                SizedBox(height: large),
                Center(
                  child: SizedBox(
                    height: 200,
                    child: ExpensePieChart(budgets: budgets),
                  ),
                ),
                SizedBox(height: medium),
                
                Text('Recent Expenses:', style: heading3),
                for (var i = 0; i < (expenses.length < 4 ? expenses.length : 4); i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(expenses[i]['budgetName']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Amount: \₱ ${expenses[i]['amount']}'),
                                Text('Date: ${expenses[i]['date']}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: medium),
                Text('Savings Summary', style: heading2D),
                SizedBox(height: large),
                Center(
                  child: SizedBox(
                    height: 200,
                    child: SavingsBarChart(savings: savings,),
                  ),
                ),

                SizedBox(height: medium),
                SavingsTable(savings: savings),

                SizedBox(height: medium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

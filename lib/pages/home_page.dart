import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perapal/components/add_button.dart';
import 'package:perapal/pages/dashboard.dart';
import 'package:perapal/pages/login.dart';
import 'package:perapal/pages/terms_page.dart';
import 'package:perapal/utils/style.dart';
import './budget_page.dart';
import './expense_page.dart';
import './savings_page.dart';
import 'package:perapal/components/header.dart';

class HomePage extends StatefulWidget {
        const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0; // State variable to track selected index

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

final List _pages = [

const Dashboard(),
const Expense(),
const Budget(),
const Savings(),
];

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()));
  }


 @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.only(top: large),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.document_scanner),
                title: const Text('Terms and Conditions'),
                onTap: () {
                  Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => const TermsAndConditions()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: logout
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Header(),
              Expanded(child: _pages[_selectedIndex]), // Use Expanded to take remaining space
            ],
          ),
        ),
        floatingActionButton: const AddButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(medium)
       ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: blue, // Customize selected item color
          unselectedItemColor: textDark, // Customize unselected item color
          backgroundColor: white,
          type: BottomNavigationBarType.fixed,
          elevation: 3,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Expense',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.savings),
              label: 'Savings',
            )
          ]
        )
       ),
      ),
    );
  }
}

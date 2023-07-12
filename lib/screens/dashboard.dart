// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:swiftpay/pages/history.dart';
import 'package:swiftpay/pages/home.dart';
import 'package:swiftpay/pages/manage_account.dart';
import 'package:swiftpay/pages/savings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SavingsPage(),
    const FinancePage(),
    const ManageAccount()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 150,
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primaryContainer),
          unselectedItemColor: Color.fromARGB(193, 158, 158, 158),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.savings), label: 'Savings'),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Finances'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Me')
          ],
        ),
      ),
    );
  }
}



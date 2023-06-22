// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:swiftpay/pages/airtime.dart';
import 'package:swiftpay/pages/history.dart';
import 'package:swiftpay/pages/home.dart';
import 'package:swiftpay/pages/savings.dart';
import 'package:swiftpay/pages/transfer.dart';
// import 'package:swiftpay/screens/auth.dart';
// import 'package:swiftpay/widgets/other_actions.dart';
// import 'package:swiftpay/widgets/quick_actions.dart';

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
    const TransferPage(),
    const AirtimePage(),
    const SavingsPage(),
    const HistoryPage()
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
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primaryContainer,
          // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sync_alt_outlined),
              label: 'Transfer',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Airtime'),
            BottomNavigationBarItem(icon: Icon(Icons.savings), label: 'Savings'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'History')
          ],
        ),
      ),
    );
  }
}


        // appBar: AppBar(
        //   title: Text('Welcome'),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           FirebaseAuth.instance.signOut();
        //           Navigator.of(context).pushReplacement(
        //               MaterialPageRoute(builder: (context) => AuthScreen()));
        //         },
        //         icon: Icon(Icons.exit_to_app))
        //   ],
        // ),
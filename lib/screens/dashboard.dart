import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftpay/screens/auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
          actions: [
            IconButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
            }, icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Center(
          child: Text('can I know my OFFENSE!!!'),
        ),
      ),
    );
  }
}
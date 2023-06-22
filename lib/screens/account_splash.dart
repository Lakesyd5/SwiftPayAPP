import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swiftpay/screens/account_number_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userId = FirebaseAuth.instance.currentUser!.uid;
final db = FirebaseFirestore.instance;

class AccountGenerateScreen extends StatefulWidget {
  const AccountGenerateScreen({super.key, required this.data});

  final data;

  @override
  State<AccountGenerateScreen> createState() => _AccountGenerateScreenState();
}

class _AccountGenerateScreenState extends State<AccountGenerateScreen> {
  var accountNumber;
  

  @override
  void initState() {
    _startTimer();
    accountNumber = _generateAccountNumber();
    // print(accountNumber);
    super.initState();
  }

  void _startTimer () {
    Timer(const Duration(seconds: 3), () { 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccountNumber(account: accountNumber),));
    });
  }

  String _generateAccountNumber() {
    Random random = Random();
    String accountNumber = '';

    for (int i = 0; i < 10; i++) {
      accountNumber += random.nextInt(10).toString();
      if (i < 9) {
        accountNumber += ' ';
      }
    }

    // saves the users account number to the database
    final data = {"Account Number": accountNumber};
    db.collection("users").doc(userId).set(data, SetOptions(merge: true));


    return accountNumber;

  }

  

  
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 70),
            Image.asset('assets/images/swiftpay.png', width: 115),
            const SizedBox(height: 215),
            Container(
              width: 170,
              height: 170,
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primaryContainer, strokeWidth: 6),
            ),  
            const SizedBox(height: 120),
            Text('Wait while we generate your account number.', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
            const SizedBox(height: 14),
            const Text('This is the number you will use to receive and send money.',textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
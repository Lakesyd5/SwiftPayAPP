import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftpay/screens/dashboard.dart';
import 'package:swiftpay/screens/savings_ui/saving_successful.dart';

class VerifySaving extends StatefulWidget {
  const VerifySaving({
    super.key,
    required this.saving,
    required this.accountNumber,
    required this.pin,
  });

  final String saving;
  final String accountNumber;
  final String pin;

  @override
  State<VerifySaving> createState() => _VerifySavingState();
}

class _VerifySavingState extends State<VerifySaving> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  var userBalance;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    getUserBalance();
  }

  void getUserBalance() async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser)
            .get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();

      if (userData != null) {
        String _userBalance = userData['Account Balance'];

        setState(() {
          userBalance = _userBalance;
        });
      }
    }
  }

  void yes() async {
    int savedUserBalance = int.parse(userBalance);
    int savingsAmount = int.parse(widget.saving);

    // Subtract the savings from the user balance
    int updatedBalance = savedUserBalance - savingsAmount;

    if (savedUserBalance > savingsAmount) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser)
            .update({'Account Balance': updatedBalance.toString()});

        saveTransaction();   

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SavingSuccessful(amount: widget.saving),
          ),
        );
      } catch (e) {
        print('Error: $e');
      }
    } else {
      // Display a message if savings amount is > than userbalance
      if (Platform.isIOS) {
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Opps!!!'),
            content: const Text('You do not have sufficient balance'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Top Up Account'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Opps!!!'),
            content: const Text('You do not have sufficient balance'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void saveTransaction() async {
    await FirebaseFirestore.instance.collection('savings').add({
      'userId': currentUser,
      'saved amount': widget.saving,
    });

    // Save Transaction to history
    FirebaseFirestore.instance.collection('history').add({
      'amount': widget.saving,
      'narration': 'Savings',
      'userId': currentUser,
      'timeStamp': DateTime.now(),
      'transactionType': 'Debit'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Are you sure you want to deposit NGN ${widget.saving}',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 7),
          Text(
            'You won\'t be able to withdraw his until after 6 months.',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(_isSaving) const CircularProgressIndicator(),
                if(!_isSaving)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size(150, 45)),
                  onPressed: yes,
                  child: const Text(
                    'YES',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size(150, 45)),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ));
                  },
                  child: const Text(
                    'NO',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

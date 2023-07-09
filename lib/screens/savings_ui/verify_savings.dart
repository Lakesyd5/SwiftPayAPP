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

  final saving;
  final accountNumber;
  final pin;

  @override
  State<VerifySaving> createState() => _VerifySavingState();
}

class _VerifySavingState extends State<VerifySaving> {
  @override
  Widget build(BuildContext context) {
    final userSavingsId = FirebaseAuth.instance.currentUser!.uid;

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
          SizedBox(height: 7),
          Text(
            'You won\'t be able to withdraw his until after 6 months.',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontSize: 13, color: Colors.grey),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(150, 45)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SavingSuccessful(amount: widget.saving)));
                  },
                  child: Text(
                    'YES',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(150, 45)),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
                  },
                  child: Text(
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

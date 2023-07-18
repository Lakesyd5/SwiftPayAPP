import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftpay/screens/dashboard.dart';

class TopupVerify extends StatefulWidget {
  const TopupVerify(
      {super.key,
      required this.airtime,
      required this.phone,
      required this.airtimeImage,
      required this.amount});

  final String phone;
  final String amount;
  final String airtime;
  final String airtimeImage;

  @override
  State<TopupVerify> createState() => _TopupVerifyState();
}

class _TopupVerifyState extends State<TopupVerify> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final formKey = GlobalKey<FormState>();
  var userBalance;
  var userPin;
  bool isProcessing = false;
  String savedPin = '';

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
        String userBalance = userData['Account Balance'];
        String userPin = userData['Pin'];

        setState(() {
          userBalance = userBalance;
          userPin = userPin;
        });
      }
    }
  }

  void makePayment() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    formKey.currentState!.save();
    int userTransactionalPin = int.parse(userPin);
    int savedUserBalance = int.parse(userBalance);
    int airtimePrice = int.parse(widget.amount);
    int savedPinInt = int.parse(savedPin);

    int updatedBalance = savedUserBalance - airtimePrice;

    if (savedUserBalance > airtimePrice) {
      if (savedPinInt == userTransactionalPin) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser)
              .update({'Account Balance': updatedBalance.toString()});

          saveTransaction();

          if (!mounted) return;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()));
        } catch (e) {
          print('Error $e');
        }
      } else {
        if (Platform.isIOS) {
          showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: const Text('DENIED'),
                    content: const Text('Incorrect Password'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ));
        } else {}
      }
    } else {
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
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ))
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
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        );
      }
    }
  }

  void saveTransaction() async {
    // Save Transaction to history
    FirebaseFirestore.instance.collection('history').add({
      'amount': widget.amount,
      'narration': 'Airtime',
      'receiver': widget.phone,
      'network': widget.airtime,
      'userId': currentUser,
      'time': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              widget.airtimeImage,
              width: 95,
              height: 95,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'You are about to top up with',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 4),
            Text(
              'NGN ${widget.amount}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Enter Pin Input
                  Form(
                    key: formKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your pin',
                          hintStyle: TextStyle(fontSize: 13),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.tryParse(value) == null ||
                            value.trim().length < 4 ||
                            value.trim().length > 4) {
                          return 'Please input a valid transaction pin';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        savedPin = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isProcessing) const CircularProgressIndicator(),

                  // Make Payment Button
                  if (!isProcessing)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: makePayment,
                      child: Text(
                        'Make Payment',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

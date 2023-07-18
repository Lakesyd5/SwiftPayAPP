import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swiftpay/screens/savings_ui/verify_savings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavingForm extends StatefulWidget {
  const SavingForm({super.key});

  @override
  State<SavingForm> createState() => _SavingFormState();
}

class _SavingFormState extends State<SavingForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  var _savings = '';
  var _accoutNumber = '';
  var _transactionPin = '';

  final currentUser = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  void nextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifySaving(
          saving: _savings,
          accountNumber: _accoutNumber,
          pin: _transactionPin,
        ),
      ),
    );
  }

  void submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      if (currentUser != null) {
        final userId = currentUser!.uid;

        // Get User document from Firestore
        final snapshot = await _firestore.collection('users').doc(userId).get();

        if (snapshot.exists) {
          final userData = snapshot.data()!;
          final savedTransactionPin = userData['Pin'];
          final savedAccountNumber = userData['Account Number'];

          if (_transactionPin == savedTransactionPin && _accoutNumber == savedAccountNumber) {
            // proceed to next screen
            nextScreen();
          } else {
            if (Platform.isIOS) {
              if(!mounted) return;
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('INVALID'),
                  content: const Text('Invalid transaction pin Or Account Number'),
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
            } else {
              if (!mounted) return;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('INVALID'),
                  content: const Text('Invalid transaction pin Or Account Number'),
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
        } else {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('User data not found.'),
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
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('User not authenticated.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Text(
                'Deposit any amount you would like to save',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Text(
                'Save an amount and get an interest of 5% within 6 months.',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              //Savings Form
              Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    children: [
                      // Amount to save input
                      TextFormField(
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(),
                            hintText: 'Enter how much you want to save',
                            hintStyle: TextStyle(fontSize: 13),
                            prefixText: '₦',
                            ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty || int.tryParse(value) == null) {
                            return 'please input an amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _savings = value!;
                        },
                      ),
                      const SizedBox(height: 17),

                      // User Account Number Input
                      TextFormField(
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(),
                            hintText: 'Enter Account number',
                            hintStyle: TextStyle(fontSize: 13)),
                        keyboardType: TextInputType.number,
                        // maxLength: 10,
                        validator: (value) {
                          if (value!.isEmpty ||
                              int.tryParse(value) == null ||
                              value.trim().length < 10) {
                            return 'please input a valid account number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _accoutNumber = value!;
                        },
                      ),
                      const SizedBox(height: 17),

                      // User Transaction Pin Input
                      TextFormField(
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(),
                            hintText: 'Enter Transaction Pin',
                            hintStyle: TextStyle(fontSize: 13)),
                        // maxLength: 4,
                        obscureText: true,
                        obscuringCharacter: '*',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty ||
                              int.tryParse(value) == null ||
                              value.trim().length > 4 ||
                              value.trim().length < 4) {
                            return 'please provide transaction pin';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _transactionPin = value!;
                        },
                      ),
                      const SizedBox(height: 40),
                      if (_isLoading) const CircularProgressIndicator(),

                      // Proceed Button
                      if (!_isLoading)
                        ElevatedButton(
                          onPressed: submit,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              minimumSize: const Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            'Proceed',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

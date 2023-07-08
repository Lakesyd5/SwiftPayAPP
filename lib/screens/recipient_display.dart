// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiftpay/screens/recipient_details.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key, required this.recipientData});

  final Map<String, dynamic> recipientData;

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  final _form = GlobalKey<FormState>();
  bool isLoading = false;
  var _amount = '';
  var _narration = '';
  var _userBalance;

  final sender_UserId = FirebaseAuth.instance.currentUser!.uid;

  void _submit() async {
    final _isValid = _form.currentState!.validate();

    if (!_isValid) {
      return;
    }

    _form.currentState!.save();

    setState(() {
      isLoading = true;
    });

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(sender_UserId)
            .get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();

      if (userData != null) {
        _userBalance = userData['Account Balance'];

        String recipientName = '${widget.recipientData['Firstname']} ${widget.recipientData['Lastname']}';
        String senderId = sender_UserId;
        String receiverAccountNumber = widget.recipientData['Account Number'];
        String amount = _amount;
        String transactionType = 'Debit';
        String narration = _narration;
        String bank = 'SWIFTPAY';
        String userBalance = _userBalance;

        // Navigate to the next screen
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipientDetailsScreen(
                  senderId: senderId,
                  receiverAccountNumber: receiverAccountNumber,
                  amount: amount,
                  transactionType: transactionType,
                  narration: narration,
                  bank: bank,
                  userBalance: userBalance,
                  recipientName: recipientName,
                  ),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display Receiver Information
              SizedBox(
                height: 40,
              ),
              Image.asset('assets/images/banks/swiftpay.png'),
              SizedBox(height: 15),
              Text(
                  '${widget.recipientData['Firstname']} ${widget.recipientData['Lastname']}',
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 5),
              Text(
                'SWIFTPAY(${widget.recipientData['Account Number']})',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 10),
              Text('Available Balance: $_userBalance'),
              SizedBox(height: 90),

              // Form Filed
              Form(
                  key: _form,
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Text('How much do you want to send?')),
                      SizedBox(height: 10),

                      // Amount Input
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter amount',
                          prefixText: '₦',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty || int.tryParse(value) == null) {
                            return 'Please input an amount.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _amount = value!;
                        },
                      ),
                      SizedBox(height: 30),

                      SizedBox(
                          width: double.infinity,
                          child: Text('Transaction Narration')),
                      SizedBox(height: 10),

                      // Narration Input
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Narration'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write a narration.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _narration = value!;
                        },
                      ),
                      SizedBox(height: 40),
                      if (isLoading) CircularProgressIndicator(),

                      // Next Button
                      if (!isLoading)
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                minimumSize: Size(double.infinity, 45)),
                            onPressed: _submit,
                            child: Text(
                              'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

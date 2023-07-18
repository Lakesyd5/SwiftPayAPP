import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftpay/screens/transaction_successful.dart';

class RecipientDetailsScreen extends StatefulWidget {
  const RecipientDetailsScreen({
    super.key,
    required this.senderId,
    required this.receiverAccountNumber,
    required this.amount,
    required this.narration,
    required this.transactionType,
    required this.bank,
    required this.userBalance,
    required this.recipientName,
  });

  final String senderId;
  final String receiverAccountNumber;
  final String amount;
  final String transactionType;
  final String narration;
  final String bank;
  final String userBalance;
  final String recipientName;

  @override
  State<RecipientDetailsScreen> createState() => _RecipientDetailsScreenState();
}

class _RecipientDetailsScreenState extends State<RecipientDetailsScreen> {
  bool _isLoading = false;

  void _pay() async {
    setState(() {
      _isLoading = true;
    });

    int userBalance = int.parse(widget.userBalance);
    int transactionAmount = int.parse(widget.amount);

    // Subtract the amount from the user balance
    int updatedBalance = userBalance - transactionAmount;

    // convert the updated balance back to string
    String updatedBalanceString = updatedBalance.toString();

    if (userBalance > transactionAmount) {
      // Save the updated balance
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.senderId)
          .update({'Account Balance': updatedBalanceString});

      // Fetch the recipient's current balance
      QuerySnapshot recipientQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Account Number', isEqualTo: widget.receiverAccountNumber)
          .get();

      if (recipientQuerySnapshot.docs.isNotEmpty) {
        // Get the first document from the query result
        Map<String, dynamic> recipientSnapshot =
            recipientQuerySnapshot.docs.first.data() as Map<String, dynamic>;

        String recipientBalance = recipientSnapshot['Account Balance'];
        int updatedRecipientBalance =
            int.parse(recipientBalance) + transactionAmount;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(recipientQuerySnapshot.docs.first.id)
            .update({'Account Balance': updatedRecipientBalance.toString()});
      } else {
        // If recipient's account is not found
        print('Recipient account not found');
      }

      //Save the transaction to the history
      saveTransaction(
        widget.senderId,
        widget.receiverAccountNumber,
        widget.amount,
        widget.transactionType,
        widget.narration,
      );

      _naviagteToNext();
    } else {
      if (Platform.isIOS) {
        showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: const Text('Insufficient Funds'),
                  content: const Text('Top up your account'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Top Up'))
                  ],
                ));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Insufficient Balance'),
            content: const Text(
                'You do not have suffient balance, Please top your account.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }

    
  }

  void _naviagteToNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionSuccess(
          amount: widget.amount,
          receiver: widget.recipientName,
        ),
      ),
    );
  }

  void saveTransaction(String senderId, String receiverAccountNumber,
      String amount, String transactionType, String narration) {
    FirebaseFirestore.instance.collection('history').add({
      'senderId': senderId,
      'receiverAccountNumber': receiverAccountNumber,
      'amount': amount,
      'transactionType': transactionType,
      'narration': narration,
      'time': DateTime.now()
    }).then((value) {
      print('Transaction Saved to history');
    }).catchError((error) => print('Failed to save transaction: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                'Transaction Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40),

              // Account Number Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Account Number'),
                      const SizedBox(height: 5),
                      Text(
                        widget.receiverAccountNumber,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              const SizedBox(height: 25),

              // Recipients Name Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recipient\'s Name'),
                      const SizedBox(height: 5),
                      Text(
                        widget.recipientName.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              const SizedBox(height: 25),

              // Recipients Bank Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recipient\'s Bank'),
                      const SizedBox(height: 5),
                      Text(
                        widget.bank,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              const SizedBox(height: 25),

              // Transaction Narration Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Transaction Narration'),
                      const SizedBox(height: 5),
                      Text(
                        widget.narration,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              const SizedBox(height: 25),

              // Amount To Be Sent
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Amount to be sent'),
                      const SizedBox(height: 5),
                      Text(
                        'NGN ${widget.amount}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              const SizedBox(height: 40),

              // Available Balance Display
              Text(
                'Available Balance: NGN ${widget.userBalance}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black45),
              ),
              const SizedBox(height: 25),
              if (_isLoading) const CircularProgressIndicator(),

              // Pay Button
              if (!_isLoading)
                ElevatedButton(
                  onPressed: _pay,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Pay NGN ${widget.amount}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

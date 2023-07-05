import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftpay/screens/recipient_display.dart';

import 'package:swiftpay/widgets/modal_screen.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _form = GlobalKey<FormState>();
  String selectedBank = '';
  String recipientAccountNumber = '';
  bool isLoading = false;
  Map<String, dynamic>? recipientUserData;

  void _submit() async {
    final _isValid = _form.currentState!.validate();

    if (!_isValid) {
      return;
    }

    _form.currentState!.save();

    setState(() {
      isLoading = true;
      recipientUserData = null;
    });

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Account Number', isEqualTo: recipientAccountNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        recipientUserData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        // If user exists
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RecipientScreen(recipientData: recipientUserData!)));
      } else {
        // If user does not exist, show an alert
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Opps!!!'),
            content: Text('The Recipient was not found'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          ),
        );
      }
    } catch (error) {
      print('Error fetching user: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    print(recipientUserData);
  }

  void _selectBank(String bankName) {
    setState(() {
      selectedBank = bankName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 37.0),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 150),
          // Transfer Details form
          Form(
            key: _form,
            child: Column(
              children: [
                // Recipients Input
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Recipient\'s Account Number',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter 10-digit Account Number'),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.trim().length < 10 ||
                        int.tryParse(value) == null) {
                      return 'Input a valid account number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    recipientAccountNumber = value!;
                  },
                ),

                const SizedBox(height: 20),

                // SelectBank Button
                ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          ModalScreen(onBankSelected: _selectBank),
                    );
                  },
                  icon: Icon(Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.background),
                  label: Text(
                    selectedBank.isEmpty ? 'Select Bank' : selectedBank,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.background),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minimumSize: const Size(double.infinity, 45.0)),
                ),
                const SizedBox(height: 35),
                if (isLoading) CircularProgressIndicator(),

                // Proceed to pay button
                if (!isLoading)
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(double.infinity, 40)),
                    child: Text(
                      'Proceed to pay',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 17,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

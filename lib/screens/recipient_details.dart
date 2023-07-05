import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipientDetailsScreen extends StatefulWidget {
  const RecipientDetailsScreen(
      {super.key,
      required this.senderId,
      required this.receiverAccountNumber,
      required this.amount,
      required this.narration,
      required this.transactionType});

  final String senderId;
  final String receiverAccountNumber;
  final String amount;
  final String transactionType;
  final String narration;

  @override
  State<RecipientDetailsScreen> createState() => _RecipientDetailsScreenState();
}

class _RecipientDetailsScreenState extends State<RecipientDetailsScreen> {
  void _pay() {
    saveTransaction(widget.senderId, widget.receiverAccountNumber, widget.amount, widget.transactionType, widget.transactionType);
  }
  void saveTransaction(String senderId, String receiverAccountNumber,
      String amount, String transactionType, String narration) {
    FirebaseFirestore.instance.collection('history').add({
      'senderId': senderId,
      'receiverAccountNumber': receiverAccountNumber,
      'amount': amount,
      'transactionType': transactionType,
      'narration': narration,
      'timeStamp': DateTime.now()
    }).then((value) {
      print('Transaction Saved to history');
    }).catchError((error) => print('Failed to save transaction: ${error}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Transaction Details',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40),
        
              // Account Number Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Account Number'),
                      SizedBox(height: 3),
                      Text('NUMBER', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              SizedBox(height: 25),
        
              // Recipients Name Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Recipient\'s Name'),
                      SizedBox(height: 3),
                      Text('NAME', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              SizedBox(height: 25),
        
              // Recipients Bank Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Recipient\'s Bank'),
                      SizedBox(height: 3),
                      Text('BANK', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              SizedBox(height: 25),
        
              // Transaction Narration Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Transaction Narration'),
                      SizedBox(height: 3),
                      Text('NARRATION', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              SizedBox(height: 25),
        
              // Amount To Be Sent
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Amount to be sent'),
                      SizedBox(height: 3),
                      Text('NGN', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              SizedBox(height: 40),
        
              // Available Balance Display
              Text('Available Balance: '),
              SizedBox(height: 35),
        
              // Pay Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Text('Pay NGN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

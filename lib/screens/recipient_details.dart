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

    // Save the updated balance
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.senderId)
        .update({'Account Balance': updatedBalanceString});

    // Fetch the recipient's current balance
    DocumentSnapshot<Map<String, dynamic>> recipientSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.receiverAccountNumber)
            .get();

    if (recipientSnapshot.exists) {
      int recipientBalance = recipientSnapshot.data()!['Account Balance'];

      // Add the transaction amount to the recipient's balance
      int updatedRecipientBalance = recipientBalance + transactionAmount;

      // Update the recipient's balance in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverAccountNumber)
          .update({'Account Balance': updatedRecipientBalance});
    }

    //Save the transaction to the history
    saveTransaction(
      widget.senderId,
      widget.receiverAccountNumber,
      widget.amount,
      widget.transactionType,
      widget.narration,
    );

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
            children: [
              SizedBox(height: 100),
              Text(
                'Transaction Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 40),

              // Account Number Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account Number'),
                      SizedBox(height: 5),
                      Text(
                        widget.receiverAccountNumber,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recipient\'s Name'),
                      SizedBox(height: 5),
                      Text(
                        widget.recipientName.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recipient\'s Bank'),
                      SizedBox(height: 5),
                      Text(
                        widget.bank,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Transaction Narration'),
                      SizedBox(height: 5),
                      Text(
                        widget.narration,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount to be sent'),
                      SizedBox(height: 5),
                      Text(
                        'NGN ${widget.amount}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/banks/greencheck.png'),
                ],
              ),
              SizedBox(height: 40),

              // Available Balance Display
              Text(
                'Available Balance: NGN ${widget.userBalance}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black45),
              ),
              SizedBox(height: 25),
              if (_isLoading) CircularProgressIndicator(),

              // Pay Button
              if (!_isLoading)
                ElevatedButton(
                  onPressed: _pay,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      minimumSize: Size(double.infinity, 45),
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

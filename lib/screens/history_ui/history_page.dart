import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final historyCollection = FirebaseFirestore.instance.collection('history');
  var userAccountNumber;

  @override
  void initState() {
    super.initState();
    getUserAccountNumber();
  }

  void getUserAccountNumber() async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser)
            .get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();

      if (userData != null) {
        String _userAccountNumber = userData['Account Number'];

        setState(() {
          userAccountNumber = _userAccountNumber;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text('Transaction Histroy')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: StreamBuilder<QuerySnapshot>(
            stream: historyCollection
                .where('senderId', isEqualTo: currentUser)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Your history Cannot be processed at this time');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No Transactions Found...', style: TextStyle(fontSize: 18, color: Colors.black38),),
                );
              } else {
                final transactionList = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: transactionList.length,
                  itemBuilder: (context, index) {
                    final transaction =
                        transactionList[index].data() as Map<String, dynamic>;
                    final senderId = transaction['senderId'];
                    final receiverAccountNumber =
                        transaction['receiverAccountNumber'];
                    final narration = transaction['narration'];
                    final isCurrentUserSender = senderId == currentUser;
                    final isCurrentUserReceiver = receiverAccountNumber == userAccountNumber;
                    final date = (transaction['time']as Timestamp).toDate();
                    // final formattedDate = Date
                    final formattedDate = DateFormat.yMMMMEEEEd().format(date);
                    // final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
                    // print(date);

                    if (isCurrentUserSender || isCurrentUserReceiver) {
                      var transactionType;
                      var amountColor;
                      var transactionAmount;

                      if (isCurrentUserSender ||
                          narration == 'Airtime' ||
                          narration == 'Savings') {
                        transactionType = 'Debit';
                        amountColor = Colors.red;
                        transactionAmount = '-₦ ${transaction['amount']}';
                      } else if (isCurrentUserReceiver) {
                        transactionType = 'Credit';
                        amountColor = Colors.green;
                        transactionAmount = '₦ ${transaction['amount']}';
                      }

                      return Container(
                        // color: Colors.grey,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionType,
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: amountColor),
                                ),
                                // SizedBox(height: 3),
                                Text(isCurrentUserReceiver ? narration : 'TRANSFER'),
                                Text(formattedDate)
                              ],
                            ),

                            Text(transactionAmount, style: TextStyle(color: amountColor),)
                          ],
                        ),
                      );
                    }

                    return SizedBox();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

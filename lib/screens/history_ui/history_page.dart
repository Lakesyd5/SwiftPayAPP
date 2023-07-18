import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final historyCollection = FirebaseFirestore.instance.collection('history');
  var userAccountNumber = '';

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
        String userAccount = userData['Account Number'];

        setState(() {
          userAccountNumber = userAccount;
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
          title: const Text('Transaction Histroy')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: StreamBuilder<QuerySnapshot>(
            stream: StreamGroup.merge([
              historyCollection
                .where('senderId', isEqualTo: currentUser)
                .snapshots(),
              historyCollection
                .where('receiverAccountNumber', isEqualTo:  userAccountNumber)
                .snapshots(),
            ]),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Your history Cannot be processed at this time');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No Transactions Found...', style: TextStyle(fontSize: 18, color: Colors.black38),),
                );
              } else {
                final transactionList = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: transactionList.length,
                  itemBuilder: (context, index) {
                    final transaction = transactionList[index].data() as Map<String, dynamic>;
                    final senderId = transaction['senderId'];
                    final receiverAccountNumber = transaction['receiverAccountNumber'];
                    final narration = transaction['narration'];
                    final isCurrentUserSender = senderId == currentUser;
                    final isCurrentUserReceiver = receiverAccountNumber == userAccountNumber;
                    final date = (transaction['time']as Timestamp).toDate();
                    final formattedDate = DateFormat.yMMMd().format(date);

                    if (isCurrentUserSender || isCurrentUserReceiver) {
                      String transactionType = '';
                      Color amountColor = Colors.black;
                      String transactionAmount = '';
                      String preText = '';

                      if (isCurrentUserSender) {
                        transactionType = 'Debit';
                        preText = 'Receiver';
                        amountColor = Colors.red;
                        transactionAmount = '-₦ ${transaction['amount']}';
                      } else if (isCurrentUserReceiver) {
                        transactionType = 'Credit';
                        preText = 'Sender';
                        amountColor = Colors.green;
                        transactionAmount = '₦ ${transaction['amount']}';
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(isCurrentUserSender ? 'TRANSFER' : 'Narration: $narration', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),),
                                const SizedBox(height: 3),
                                if(isCurrentUserSender)
                                Text('$preText: $receiverAccountNumber', style: const TextStyle(fontWeight: FontWeight.w500),),
                                // if(isCurrentUserReceiver)
                                // Text('$preText: '),
                                Text(formattedDate, style: Theme.of(context).textTheme.labelMedium,)
                              ],
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(66, 199, 198, 198),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text(transactionAmount, style: TextStyle(color: amountColor, fontSize: 14, fontWeight: FontWeight.w600),),
                            )
                          ],
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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

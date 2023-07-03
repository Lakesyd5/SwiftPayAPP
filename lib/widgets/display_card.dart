import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardDisplay extends StatelessWidget {
  const CardDisplay({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(userId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                // color: Colors.black,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Balance',
                              style: TextStyle(color: Colors.white),
                            ),

                            //--> History Button
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: const [
                                  Text(
                                    'History',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ]
                        ),
                    const SizedBox(height: 9),

                    FutureBuilder(
                      future: fetchUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While fetching data display a circular indicator
                          return CircularProgressIndicator();
                        } else if(snapshot.hasError) {
                          // If there is an error 
                          return Text('Error: ${snapshot.hasError}'); 
                        } else if (snapshot.hasData) {
                          final userData = snapshot.data!.data();
                          final balance = userData?['Account Balance']?? '';
                        
                        return Text('NGN $balance.00', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),);
                        }else {
                          return Container();
                        }
                      }
                    ),
                  ],
                ),
              );
  }
}
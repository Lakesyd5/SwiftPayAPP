import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:swiftpay/widgets/display_card.dart';
import 'package:swiftpay/widgets/other_actions.dart';
import 'package:swiftpay/widgets/quick_actions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(userId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                          future: fetchUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Display a loading indicator while fetching data
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              // Display an error message if there was an error
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (snapshot.hasData) {
                              // Data fetched successfully, continue building the UI
                              final userData = snapshot.data!.data();
                              final firstName = userData?['Firstname'] ?? '';
                              final lastName = userData?['Lastname'] ?? '';
                              final imageURL = userData?['imageURL'] ?? '';
                              return Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white54,
                                    backgroundImage: imageURL.isNotEmpty ? NetworkImage(imageURL) : null,
                                    child: imageURL.isNotEmpty ? null : Icon(Icons.person),
                                  ),
                                  const SizedBox(width: 6),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Hello, $firstName'),
                                      // SizedBox(height: 4),
                                      Text('$firstName $lastName',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                      // SizedBox(width: 150),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_none_rounded,
                            size: 37.0,
                            color: Theme.of(context).colorScheme.background,
                          ))
                    ]),
                const SizedBox(height: 20),

                //--> Card
                CardDisplay(),
                const SizedBox(height: 30),

                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),

                // --> Quick Actions
                QuickActionScreen(),
                const SizedBox(height: 30),

                Text(
                  'Other Actions',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),

                // -->Other ACtions
                OtherActions(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

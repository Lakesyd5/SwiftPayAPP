import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:swiftpay/screens/auth.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(userId).get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[250],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                final phoneNumber = userData?['Phone Number'] ?? '';
                final accNumber = userData?['Account Number'] ?? '';
                final email = userData?['email'] ?? '';
                final pin = userData?['Pin'] ?? '';

                return Column(
                  children: [
                    // First Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          CircleAvatar(),
                          SizedBox(height: 10),
                          Text(
                            'Hello, $firstName',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text('$firstName $lastName'),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SwiftPay Account Number',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    accNumber,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              // SizedBox(width: 19),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SwiftPay Transaction Pin',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    pin,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Second Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username(First Name)',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                firstName,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Full Name',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                '$firstName $lastName',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Email Address',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phone Number',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                phoneNumber,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Third Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Generate SwiftPay Card',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Get your personalized swiftpay card',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Last Container
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AuthScreen(),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Log Out',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('Log out of this account',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium)
                                  ],
                                ),
                                Image.asset('assets/images/power_button.png')
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

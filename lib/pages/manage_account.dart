import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftpay/read%20data/get_user_data.dart';

import 'package:swiftpay/screens/auth.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  // final user = FirebaseAuth.instance.currentUser;
  final data = '';


  Future<String?> getUser(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc().get();
      final data = snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      return 'Error fetching user';
    }
  }

  // final userData = FirebaseFirestore.instance.collection('users').snapshots();

  // var docId = ''; 

  // // get the collection
  // Future getDocId() async {
  //   await FirebaseFirestore.instance.collection('users').get().then((snapshot) => snapshot.docs.forEach((element) { 
  //     print(element.reference);
  //     docId = element.reference as String;
  //   }));
  // }

  
    

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[250],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                // First Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      CircleAvatar(),
                      SizedBox(height: 10),
                      Text('Hello, Michael', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                      SizedBox(height: 5),
                      Text('Michael Jackson'),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('SwiftPay Account Number', style: Theme.of(context).textTheme.labelMedium,),
                              SizedBox(height: 6),
                              Text('7014024882', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                            ],
                          ),
                          // SizedBox(width: 19),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('SwiftPay Transaction Pin', style: Theme.of(context).textTheme.labelMedium,),
                              SizedBox(height: 6),
                              Text('3962', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                

                // Second Container
                FutureBuilder(
                  // future: getDocId(),
                  builder: (context, snapshot) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text('Username(First Name)', style: Theme.of(context).textTheme.labelMedium,),
                            // GetUserData(documentId: getDocId()),
                            // Text('Michael', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                          ],),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text('Full Name', style: Theme.of(context).textTheme.labelMedium,),
                            Text('Michael Jackson', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                          ],),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text('Email Address', style: Theme.of(context).textTheme.labelMedium,),
                            Text('michaeljackson@gmail.com', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                          ],),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text('Phone Number', style: Theme.of(context).textTheme.labelMedium,),
                            Text('08037622324', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                          ],),
                        ],
                      ),
                    );
                  }
                ),
                SizedBox(height: 20),
                

                // Third Container
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Generate SwiftPay Card', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5),
                                Text('Get your personalized swiftpay card', style: Theme.of(context).textTheme.labelMedium,),
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen(),));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Log Out', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text('Log out of this account', style: Theme.of(context).textTheme.labelMedium)
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
            ),
          )),
    );
  }
}

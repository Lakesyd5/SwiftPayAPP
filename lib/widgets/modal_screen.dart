// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class ModalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child:  Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text('Select Bank', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            SizedBox(height: 65),

            Wrap(
              runSpacing: 10,
              spacing: 30,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // SwiftPay Bank Select
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('assets/images/banks/swiftpay.png'),
                      SizedBox(height: 10),
                      Text('SWIFTPAY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                // Firstbank Select
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('assets/images/banks/firstbank.png'),
                      SizedBox(height: 10),
                      Text('FIRST BANK PLC', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                // GT BANk Select
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('assets/images/banks/gtbank.png'),
                      SizedBox(height: 10),
                      Text('GTBANK PLC', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                // Kuda Select
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('assets/images/banks/kuda.png'),
                      SizedBox(height: 10),
                      Text('KUDA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                // Access Bank Select
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('assets/images/banks/access.png'),
                      SizedBox(height: 10),
                      Text('ACCESS BANK', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                // Opay Select
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('assets/images/banks/opay.png'),
                      SizedBox(height: 10),
                      Text('OPAY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
    );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class ModalScreen extends StatefulWidget {
  const ModalScreen({super.key, required this.onBankSelected});

  final Function(String) onBankSelected;

  @override
  State<ModalScreen> createState() => _ModalScreenState();
}

class _ModalScreenState extends State<ModalScreen> {
  String selectedBank = '';

  void selectBank(String bankName) {
    Navigator.pop(context); // Close the Modal Screen
    widget.onBankSelected(bankName);  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                GestureDetector(
                  onTap: () {
                    selectBank ('SwiftPay');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset('assets/images/banks/swiftpay.png'),
                        SizedBox(height: 10),
                        Text('SWIFTPAY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),

                // Firstbank Select
                GestureDetector(
                  onTap: () {
                    selectBank ('Firstbank');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset('assets/images/banks/firstbank.png'),
                        SizedBox(height: 10),
                        Text('FIRST BANK PLC', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),

                // GT BANk Select
                GestureDetector(
                  onTap: () {
                    selectBank ('GTBank');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset('assets/images/banks/gtbank.png'),
                        SizedBox(height: 10),
                        Text('GTBANK PLC', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),

                // Kuda Select
                GestureDetector(
                  onTap: () {
                    selectBank ('Kuda MFB');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset('assets/images/banks/kuda.png'),
                        SizedBox(height: 10),
                        Text('KUDA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),

                // Access Bank Select
                GestureDetector(
                  onTap: () {
                    selectBank ('Access Bank');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset('assets/images/banks/access.png'),
                        SizedBox(height: 10),
                        Text('ACCESS BANK', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),

                // Opay Select
                GestureDetector(
                  onTap: () {
                    selectBank ('Opay');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset('assets/images/banks/opay.png'),
                        SizedBox(height: 10),
                        Text('OPAY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
    );
  }
}
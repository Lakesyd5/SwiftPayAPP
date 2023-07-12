// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:swiftpay/screens/airtime_ui/select_network.dart';
import 'package:swiftpay/screens/transfer.dart';

class QuickActionScreen extends StatelessWidget {
  const QuickActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9.3,
      runSpacing: 9.3,
      children: [
        // Transfer Tab
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => TransferPage(),
            ));
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      color: Colors.white,
                      size: 15,
                    )),
                const SizedBox(height: 15),
                Text(
                  'Transfer',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Container(
                    width: 175,
                    child: Text(
                      'Send any amount starting from NGN 10 to any bank account.',
                      style: Theme.of(context).textTheme.labelMedium,
                    )),
                SizedBox(height: 15),
                Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ),

        // Receive Money Tab
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer),
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.white,
                    size: 15,
                  )),
              const SizedBox(height: 15),
              Text(
                'Receive Money',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Container(
                  width: 175,
                  child: Text(
                    'It\'s easy, request for money from other Swiftpay Users',
                    style: Theme.of(context).textTheme.labelMedium,
                  )),
              SizedBox(height: 15),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),

        // Add Money Tab
        Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    )),
                const SizedBox(height: 15),
                Text(
                  'Add Money',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Container(
                    width: 175,
                    child: Text(
                      'Fund your SwiftPay account from other bank accounts.',
                      style: Theme.of(context).textTheme.labelMedium,
                    )),
                SizedBox(height: 15),
                Icon(Icons.arrow_forward)
              ],
            )),

        // Airtime Top-Up Tab
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectNetworkScreen()));
          },
          child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primaryContainer),
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 15,
                      )),
                  const SizedBox(height: 15),
                  Text(
                    'Airtime TopUp',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Container(
                      width: 175,
                      child: Text(
                        'Easily buy airtime and top up with just a few clicks',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                  SizedBox(height: 15),
                  Icon(Icons.arrow_forward)
                ],
              )),
        ),
      ],
    );
  }
}

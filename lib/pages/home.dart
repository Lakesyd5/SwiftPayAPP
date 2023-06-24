import 'package:flutter/material.dart';
import 'package:swiftpay/widgets/display_card.dart';
import 'package:swiftpay/widgets/other_actions.dart';
import 'package:swiftpay/widgets/quick_actions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [ Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Hello, Micheal'),
                          // SizedBox(height: 4),
                          Text('Michael Jackson',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
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
          ),]
        ),
      ),
    );
  }
}

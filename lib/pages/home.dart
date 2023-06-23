import 'package:flutter/material.dart';
import 'package:swiftpay/widgets/other_actions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              Container(
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
                        const Text(
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
                      ],
                    ),
                    const SizedBox(height: 9),

                    const Text('NGN 15,000.00', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.start,
              ),
              // const SizedBox(height: 10),
              // const OtherActions(),
            ],
          ),
        ),
      ),
    );
  }
}

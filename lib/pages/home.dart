import 'package:flutter/material.dart';
import 'package:swiftpay/widgets/other_actions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 55,),
                Row(children: [
                  CircleAvatar(),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const[
                    Text('Hello, Micheal'),
                    SizedBox(height: 4),
                    Text('Michael Jackson'),
                  ],),
                  SizedBox(width: 50),
                  IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none_rounded, size: 37.0, color: Theme.of(context).colorScheme.background,))
                ]),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'See all Cards',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.5),
                      child: Image.asset(
                        'assets/images/dashboard_card.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        // height: 0,
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SwiftPay Debit Card',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              'Account Balance',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '15,000',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          minimumSize: const Size(160, 35)),
                      child: Text(
                        'Fund Account',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          minimumSize: const Size(160, 35)),
                      child: Text(
                        'Add Card',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'Other Actions',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10),
                const OtherActions(),
              ],
            ),
          ),
    );
  }
}
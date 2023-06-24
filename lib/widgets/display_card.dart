import 'package:flutter/material.dart';

class CardDisplay extends StatelessWidget {
  const CardDisplay({super.key});

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
              );
  }
}
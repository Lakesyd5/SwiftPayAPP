import 'package:flutter/material.dart';

class OtherActions extends StatelessWidget {
  const OtherActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 6,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Wrap(
            spacing: 9.0, // gap between adjacent chips
            runSpacing: 30.0, // gap between lines
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 78,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/internet_access.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Internet Services',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 78,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/betting_funds.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Betting Funds',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 78,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/loan.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Borrow Loan',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/dstv_payment.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'DSTv Payment',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 78,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/electricity.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Electricity Bills',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 78,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/netflix.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Netflix Payment',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 78,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/fast_food.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Fast Food',
                      textAlign: TextAlign.justify,
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.cente,
                  children: [
                    Image.asset(
                      'assets/images/transport.png',
                      width: 35,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Commercial Transport',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}


// Row(
//           children: [
//             Container(
//                 width: 90,
//
//                 child: Column(
//                   // crossAxisAlignment: CrossAxisAlignment.cente,
//                   children: [
//                     Image.asset(
//                       'assets/images/internet_access.png',
//                       width: 35,
//                     ),
//                     Text(
//                       'Internet Services',
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ))
//           ],
//         ),
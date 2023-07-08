import 'package:flutter/material.dart';
import 'package:swiftpay/screens/dashboard.dart';

class TransactionSuccess extends StatelessWidget {
  const TransactionSuccess(
      {super.key, required this.amount, required this.receiver});
  final String amount;
  final String receiver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 200, right: 40, left: 40),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset('assets/images/success.png'),
            const SizedBox(height: 40),
            const Text(
              'Successfully Transferred',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
              const Text('You'),
              const SizedBox(width: 3),
              const Text('sent'),
              const SizedBox(width: 3),
              Text('NGN $amount', style: const TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(width: 3),
              const Text('to'),
              const SizedBox(width: 3),
              Text(receiver.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold))
            ],),
            const SizedBox(height: 80),

            // OK Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(double.infinity, 45)),
              child: Text(
                'Go Home',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:swiftpay/pages/home.dart';

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
        padding: EdgeInsets.only(top: 200, right: 40, left: 40),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset('assets/images/success.png'),
            SizedBox(height: 40),
            Text(
              'Successfully Transferred',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            // Text('You sent $amount to ${receiver.toUpperCase()}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('You'),
              SizedBox(width: 3),
              Text('sent'),
              SizedBox(width: 3),
              Text('NGN $amount', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 3),
              Text('to'),
              SizedBox(width: 3),
              Text('${receiver.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.bold))
            ],),
            SizedBox(height: 80),

            // OK Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: Size(double.infinity, 45)),
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

import 'package:flutter/material.dart';
import 'package:swiftpay/screens/dashboard.dart';

class SavingSuccessful extends StatelessWidget {
  const SavingSuccessful({super.key, required this.amount});

  final amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/success.png'),
            SizedBox(height: 30),
            const Text(
              'Successfully Deposited',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You'),
                SizedBox(width: 3),
                Text('saved'),
                SizedBox(width: 3),
                Text('NGN', style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 3),
                Text(amount, style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 50),
      
            // Go home button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: Size(double.infinity, 45)
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
              },
              child: Text('Go Home', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}

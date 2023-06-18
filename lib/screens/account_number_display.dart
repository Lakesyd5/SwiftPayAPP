import 'package:flutter/material.dart';
import 'package:swiftpay/screens/set_pin.dart';

class AccountNumber extends StatelessWidget {
  const AccountNumber({super.key, required this.account});

  final account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 38),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Image.asset('assets/images/swiftpay.png', width: 115),
            const SizedBox(height: 215),
            Text(
              'Your Account Number',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                account,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    wordSpacing: 10),
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SetPinScreen(),));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 43),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer),
                child: Text(
                  'Okay',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ))
          ],
        ),
      ),
    );
  }
}

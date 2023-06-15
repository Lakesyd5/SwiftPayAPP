import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swiftpay/screens/onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
  
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 2), () { 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/swiftpay_white.png'),
              width: 180,
            ),
            const SizedBox(height: 10),
            Text(
              'Speedy transactions, Zero Stress.', style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ),
    );
  }
}

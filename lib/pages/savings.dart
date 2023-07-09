import 'package:flutter/material.dart';
import 'package:swiftpay/screens/savings_ui/saving_onboarding.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SavingOnboarding(),
      )
    );
  }
}
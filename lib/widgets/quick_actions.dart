import 'package:flutter/material.dart';

class QuickActionScreen extends StatefulWidget {
  const QuickActionScreen({super.key});

  @override
  State<QuickActionScreen> createState() => _QuickActionScreenState();
}

class _QuickActionScreenState extends State<QuickActionScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
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
    ],);
  }
}
import 'package:flutter/material.dart';
import 'package:swiftpay/screens/auth.dart';

class IntroScreenTWo extends StatelessWidget {
  const IntroScreenTWo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(
          image: AssetImage('assets/images/onboarding_screen_two.png'),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 95, right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Speedy transactions with no issues guaranteed',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground),
                      // textWidthBasis: TextWidthBasis.parent,
                ),
                const SizedBox(height: 9),
                Text(
                  'It\'s in the name. Trust your transactions are processed quickly without frustrating errors.',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const AuthScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(double.infinity, 60)
                  ),
                  child: Text(
                    'Get Started',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swiftpay/widgets/intro_page_one.dart';
import 'package:swiftpay/widgets/intro_page_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller for Pages in PageView
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for Onboardings
          PageView(
            controller: _controller,
            children: [
              IntroScreenOne(controller: _controller),
              const IntroScreenTWo(),
            ],
          ),

          // Dot Indicators
          Container(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 2,
              effect: SlideEffect(
                activeDotColor: Theme.of(context).colorScheme.primaryContainer,
                // radius: 4,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

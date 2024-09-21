import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/views/welcome_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(children: [
        Center(
          child: LottieBuilder.asset('assets/lottie/SplashAnimation.json'),
        )
      ]),
      nextScreen: const WelcomePage(),
      splashIconSize: 500,
      backgroundColor: Colors.black,
      animationDuration: const Duration(milliseconds: 500),
      splashTransition: SplashTransition.fadeTransition,
      
    );
  }
}

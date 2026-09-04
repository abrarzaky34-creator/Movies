import 'dart:async';
import 'package:flutter/material.dart';

import 'onboarding_screen_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Logo
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFC107),
                      width: 2,
                    ),
                  ),
                ),

                const Icon(
                  Icons.play_arrow,
                  color: Color(0xFFFFC107),
                  size: 42,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Route
            const Text(
              'Route',
              style: TextStyle(
                color: Color(0xFFFFC107),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 8),

            // Supervised by
            const Text(
              'Supervised by Mohamed Nabil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
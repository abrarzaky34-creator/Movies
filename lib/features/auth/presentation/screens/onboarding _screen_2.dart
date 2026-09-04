import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [


            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.76,
              child: Image.asset(
                'assets/michael-movies-poster-01.webp',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),


            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: screenHeight * 0.30,
                padding: const EdgeInsets.fromLTRB(
                  25,
                  30,
                  25,
                  20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),

                child: Column(
                  children: [


                    const Text(
                      'Discover Movies',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),


                    const Text(
                      'Explore a vast collection of movies in all\n'
                          'qualities and genres. Find your next\n'
                          'favorite film with ease.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD600),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
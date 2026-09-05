import 'package:flutter/material.dart';

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // FULL SCREEN IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/best-movie-posters-jurassic-park.webp',
              fit: BoxFit.cover,
            ),
          ),

          // DARK GRADIENT
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.85),
                    Colors.black,
                  ],
                  stops: const [
                    0.0,
                    0.45,
                    0.72,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),

                      ),
                    ),
                  ),
                ),

                const Spacer(),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    22,
                    28,
                    22,
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.88),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Create Watchlists',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Save movies to your watchlist to keep\n'
                            'track of what you want to watch next.\n'
                            'Enjoy films in various qualities and\n'
                            'genres.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // NEXT
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {
                            // هنضيف هنا الشاشة اللي بعد الـOnboarding
                            // لما تبدأي فيها.
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFFFFE000),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // BACK
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                            const Color(0xFFFFE000),
                            side: const BorderSide(
                              color: Color(0xFFFFE000),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
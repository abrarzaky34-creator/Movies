import 'package:flutter/material.dart';

class OnboardingScreen6 extends StatelessWidget {
  const OnboardingScreen6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              'assets/images/6.png',
              fit: BoxFit.cover,
            ),
          ),


          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
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
                    color: Colors.black.withOpacity(0.90),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [

                      const Text(
                        'Start Watching Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),


                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {
                            // هنا هنحط الشاشة الرئيسية
                            // بعد ما نخلص الـ Onboarding
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFE000),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Finish',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),


                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFFFE000),
                            side: const BorderSide(
                              color: Color(0xFFFFE000),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
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
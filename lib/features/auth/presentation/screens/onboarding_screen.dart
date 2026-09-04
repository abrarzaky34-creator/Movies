import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/americana-movies-he-poster-02.webp',
      'title': 'Find Your Next\nFavorite Movie Here',
      'description':
      'Get access to a huge library of movies\nto suit all tastes. You will surely like it.',
      'button': 'Explore Now',
    },
    {
      'image': 'assets/images/michael-movies-poster-01.webp',
      'title': 'Discover Movies',
      'description':
      'Explore a vast collection of movies in all\nqualities and genres. Find your next\nfavorite film with ease.',
      'button': 'Next',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),

      body: SafeArea(
        child: Center(
          child: Container(
            width: 170,
            height: 370,
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(2),
            ),

            child: Column(
              children: [

                // Movie Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                  child: Image.asset(
                    pages[currentPage]['now-you-see-me-now-you-dont-movies-he-poster-01.webp']!,
                    width: 170,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),

                // Text
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Text(
                          pages[currentPage]['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          pages[currentPage]['description']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 8,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Button
                        SizedBox(
                          width: double.infinity,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {

                              if (currentPage < pages.length - 1) {
                                setState(() {
                                  currentPage++;
                                });
                              }

                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),

                            child: Text(
                              pages[currentPage]['button']!,
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
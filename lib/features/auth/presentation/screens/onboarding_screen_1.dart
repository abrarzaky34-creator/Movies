import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.15,
            left: -size.width * 0.2,
            width: size.width * 1.6,
            height: size.height * 0.9,
            child: Transform.rotate(
              angle: -0.2,
              child: const MoviePosterGrid(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                    Colors.black,
                    Colors.black,
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Find Your Next\nFavorite Movie Here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "Get access to a huge library of movies\nto suit all tastes. You will surely like it.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD700),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: const Text(
                            "Explore Now",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
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

class MoviePosterGrid extends StatelessWidget {
  const MoviePosterGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> posterUrls = [
      'assets/images/fall-movies-he-poster-01.webp',
      'assets/images/michael-movies-poster-01.webp',
      'assets/images/now-you-see-me-now-you-dont-movies-he-poster-01.webp',
      'assets/images/oppenheimer0515202301_580x.webp',
      'assets/images/trending-paw-patrol-dino-movie-posters.webp',
      'assets/images/wick-is-pain-movies-he-poster-01.webp',
    ];

    final repeatedUrls = List.generate(5, (_) => posterUrls).expand((x) => x).toList();

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: repeatedUrls.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            repeatedUrls[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[900],
              child: const Icon(Icons.movie, color: Colors.white24),
            ),
          ),
        );
      },
    );
  }
}
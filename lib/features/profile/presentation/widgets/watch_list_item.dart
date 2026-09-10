import 'package:flutter/material.dart';

class WatchListItem extends StatelessWidget {
  const WatchListItem({
    super.key,
    required this.posterUrl,
    required this.rating,
  });

  final String posterUrl;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 122 / 179.58,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF252525),
                  child: const Icon(
                    Icons.movie,
                    color: Colors.grey,
                    size: 30,
                  ),
                );
              },
            ),

            Positioned(
              top: 5,
              left: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFC107),
                      size: 11,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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
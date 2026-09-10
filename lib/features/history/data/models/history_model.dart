class HistoryModel {
  final int movieId;
  final String title;
  final String image;
  final double rating;
  final int year;
  final DateTime watchedAt;

  HistoryModel({
    required this.movieId,
    required this.title,
    required this.image,
    required this.rating,
    required this.year,
    required this.watchedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'title': title,
      'image': image,
      'rating': rating,
      'year': year,
      'watchedAt': watchedAt.toIso8601String(),
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      movieId: json['movieId'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      year: json['year'] ?? 0,
      watchedAt: DateTime.tryParse(
        json['watchedAt'] ?? '',
      ) ??
          DateTime.now(),
    );
  }
}
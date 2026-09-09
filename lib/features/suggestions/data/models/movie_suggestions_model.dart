class MovieSuggestionModel {
  final int id;
  final String title;
  final String mediumCoverImage;
  final double rating;
  final int year;

  MovieSuggestionModel({
    required this.id,
    required this.title,
    required this.mediumCoverImage,
    required this.rating,
    required this.year,
  });

  factory MovieSuggestionModel.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      year: json['year'] ?? 0,
    );
  }
}
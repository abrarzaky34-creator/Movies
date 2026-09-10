class MovieModel {
  final int id;
  final String title;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<String> genres;

  const MovieModel({
    required this.id,
    required this.title,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}
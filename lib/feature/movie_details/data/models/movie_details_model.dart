class MovieDetailsModel {
  final int id;
  final String title;
  final String description;
  final String largeCoverImage;
  final String backgroundImage;
  final String rating;
  final int runtime;
  final List<String> genres;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.largeCoverImage,
    required this.backgroundImage,
    required this.rating,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description_full'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      rating: json['rating']?.toString() ?? '0',
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}
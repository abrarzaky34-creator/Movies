class MovieModel {
  final int id;
  final String title;
  final String year;
  final String rating;
  final String coverImage;

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.coverImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      year: json['year']?.toString() ?? '',
      rating: json['rating']?.toString() ?? '',
      coverImage: json['large_cover_image'] ?? '',
    );
  }
}
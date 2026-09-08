class Movie {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final int likeCount;
  final String coverImageUrl;
  final String backgroundImageUrl;
  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.likeCount,
    required this.coverImageUrl,
    required this.backgroundImageUrl,
  });
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: (json['title_english'] as String?)?.isNotEmpty == true
          ? json['title_english'] as String
          : json['title'] as String,
      year: json['year'] as int,
      rating: (json['rating'] as num).toDouble(),
      runtime: json['runtime'] as int,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((g) => g.toString())
          .toList(),
      summary: json['summary'] as String? ?? '',
      likeCount: json['like_count'] as int? ?? 0,
      coverImageUrl: json['medium_cover_image'] as String? ?? '',
      backgroundImageUrl: json['background_image'] as String? ?? '',
    );
  }
}
import 'package:dio/dio.dart';

class Movie {
  final int id;
  final String title;
  final String coverImageUrl;
  final double rating;
  final String summary;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.coverImageUrl,
    required this.rating,
    required this.summary,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      coverImageUrl: json['medium_cover_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      summary: json['summary'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}

class BrowseService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://movies-api.accel.li/api/v2/',
    ),
  );

  // Get movies from API
  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await _dio.get(
        'list_movies.json',
        queryParameters: {
          'limit': 50,
          'sort_by': 'rating',
        },
      );

      final data = response.data['data'];

      if (data == null || data['movies'] == null) {
        return [];
      }

      final moviesJson = data['movies'] as List;

      return moviesJson
          .map(
            (movie) => Movie.fromJson(
          Map<String, dynamic>.from(movie),
        ),
      )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Failed to load movies: ${e.message}',
      );
    } catch (e) {
      throw Exception(
        'Failed to load movies: $e',
      );
    }
  }

  // Get all unique genres
  Set<String> extractGenres(List<Movie> movies) {
    final Set<String> genres = {};

    for (final movie in movies) {
      genres.addAll(movie.genres);
    }

    return genres;
  }

  // Filter movies by selected genre
  List<Movie> filterMoviesByGenre(
      List<Movie> movies,
      String genre,
      ) {
    return movies.where((movie) {
      return movie.genres.any(
            (movieGenre) =>
        movieGenre.toLowerCase() == genre.toLowerCase(),
      );
    }).toList();
  }
}
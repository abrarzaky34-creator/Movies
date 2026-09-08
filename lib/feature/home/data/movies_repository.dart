import 'package:dio/dio.dart';
import '../../../core/models/movie.dart';
class MoviesRepository {
  final Dio _dio;
  MoviesRepository(this._dio);
  Future<List<Movie>> fetchMovies({int limit = 50, int page = 1}) async {
    final response = await _dio.get(
      '/list_movies.json',
      queryParameters: {
        'limit': limit,
        'page': page,
        'sort_by': 'rating',
        'order_by': 'desc',
      },
    );
    final moviesJson =
        response.data['data']['movies'] as List<dynamic>? ?? [];
    return moviesJson
        .map((m) => Movie.fromJson(m as Map<String, dynamic>))
        .toList();
  }
  Future<List<Movie>> fetchAllMovies({
    int limit = 50,
    int maxPages = 20,
  }) async {
    final allMovies = <Movie>[];
    var page = 1;
    while (page <= maxPages) {
      final response = await _dio.get(
        '/list_movies.json',
        queryParameters: {
          'limit': limit,
          'page': page,
          'sort_by': 'rating',
          'order_by': 'desc',
        },
      );
      final data = response.data['data'] as Map<String, dynamic>?;
      final moviesJson = data?['movies'] as List<dynamic>? ?? [];
      if (moviesJson.isEmpty) break;
      allMovies.addAll(
        moviesJson.map((m) => Movie.fromJson(m as Map<String, dynamic>)),
      );
      final movieCount = data?['movie_count'] as int?;
      if (movieCount != null && allMovies.length >= movieCount) break;
      if (moviesJson.length < limit) break;
      page++;
    }
    return allMovies;
  }
}
import 'package:dio/dio.dart';

import '../models/movie_suggestions_model.dart';

class MovieSuggestionsDataSource {
  final Dio dio;

  MovieSuggestionsDataSource(this.dio);

  Future<List<MovieSuggestionModel>> getMovieSuggestions(
      int movieId,
      ) async {
    final response = await dio.get(
      'https://yts.mx/api/v2/movie_suggestions.json',
      queryParameters: {
        'movie_id': movieId,
      },
    );

    final List movies =
        response.data['data']['movies'] ?? [];

    return movies
        .map(
          (movie) => MovieSuggestionModel.fromJson(movie),
    )
        .toList();
  }
}
import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class BrowseRemoteDataSource {
  final Dio dio;

  BrowseRemoteDataSource(this.dio);

  Future<List<MovieModel>> getMovies() async {
    final response = await dio.get(
      'https://yts.mx/api/v2/list_movies.json',
    );

    final movies = response.data['data']['movies'] as List<dynamic>? ?? [];

    return movies
        .map(
          (movie) => MovieModel.fromJson(
        movie as Map<String, dynamic>,
      ),
    )
        .toList();
  }
}
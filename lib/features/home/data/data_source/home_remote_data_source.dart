import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  static const String baseUrl = 'https://movies-api.accel.li/api/v2/';

  Future<List<MovieModel>> getMovies({int page = 1}) async {
    final response = await dio.get(
      '${baseUrl}list_movies.json',
      queryParameters: {
        'page': page,
        'limit': 20,
      },
    );

    final List movies = response.data['data']['movies'] ?? [];

    return movies
        .map((movie) => MovieModel.fromJson(movie))
        .toList();
  }
}
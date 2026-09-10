import 'package:dio/dio.dart';

class MovieDetailsRemoteDataSource {
  final Dio dio;

  MovieDetailsRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final response = await dio.get(
      'https://yts.mx/api/v2/movie_details.json',
      queryParameters: {
        'movie_id': movieId,
      },
    );

    return response.data['data']['movie'];
  }
}
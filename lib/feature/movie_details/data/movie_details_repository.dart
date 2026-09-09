import 'data_sources/movie_details_remote_data_source.dart';
import 'models/movie_details_model.dart';

class MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepository(this.remoteDataSource);

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final movieJson = await remoteDataSource.getMovieDetails(movieId);

    return MovieDetailsModel.fromJson(movieJson);
  }
}
import 'data_source/home_remote_data_source.dart';
import 'models/movie_model.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository(this.remoteDataSource);

  Future<List<MovieModel>> getMovies({int page = 1}) async {
    return await remoteDataSource.getMovies(page: page);
  }
}
import '../data_sources/browse_remote_data_source.dart';
import '../models/movie_model.dart';

class BrowseRepository {
  final BrowseRemoteDataSource remoteDataSource;

  BrowseRepository(this.remoteDataSource);

  Future<List<MovieModel>> getMovies() {
    return remoteDataSource.getMovies();
  }
}
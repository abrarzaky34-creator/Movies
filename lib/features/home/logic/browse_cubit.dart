import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/movie_model.dart';
import '../data/repositories/browse_repository.dart';

part 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final BrowseRepository repository;

  BrowseCubit(this.repository) : super(BrowseInitial());

  Future<void> getMovies() async {
    emit(BrowseLoading());

    try {
      final movies = await repository.getMovies();

      final genres = <String>{};

      for (final movie in movies) {
        genres.addAll(movie.genres);
      }

      emit(
        BrowseSuccess(
          movies: movies,
          genres: genres.toList(),
        ),
      );
    } catch (e) {
      emit(BrowseError(e.toString()));
    }
  }
}
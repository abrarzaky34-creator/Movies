import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/home_repository.dart';
import '../../data/models/movie_model.dart';

part 'home_movies_state.dart';

class HomeMoviesCubit extends Cubit<HomeMoviesState> {
  final HomeRepository repository;

  HomeMoviesCubit(this.repository) : super(HomeMoviesInitial());

  Future<void> fetchMovies() async {
    emit(HomeMoviesLoading());
    try {
      final movies = await repository.getMovies();
      emit(HomeMoviesLoaded(movies));
    } catch (e) {
      emit(HomeMoviesError(e.toString()));
    }
  }
}
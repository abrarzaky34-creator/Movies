import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/movie.dart';
import '../data/movies_repository.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository _repository;
  final Random _random = Random();
  static const int _featuredPoolSize = 30;
  static const int _featuredCount = 5;
  static const List<String> _categories = [
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Thriller',
    'Animation',
    'Adventure',
    'Crime',
    'Fantasy',
    'Mystery',
  ];

  MoviesBloc(this._repository) : super(const MoviesState()) {
    on<HomeMoviesRequested>(_onMoviesRequested);
  }

  Future<void> _onMoviesRequested(
      HomeMoviesRequested event,
      Emitter<MoviesState> emit,
      ) async {
    emit(state.copyWith(status: MoviesStatus.loading));
    try {
      final movies = await _repository.fetchAllMovies();
      final topPool = movies.take(_featuredPoolSize).toList()
        ..shuffle(_random);
      final featured = topPool.take(_featuredCount).toList();

      final shuffledCategories = List<String>.from(_categories)
        ..shuffle(_random);
      final category = shuffledCategories.firstWhere(
            (genre) => movies.any((m) => m.genres.contains(genre)),
        orElse: () => 'Action',
      );

      emit(state.copyWith(
        status: MoviesStatus.loaded,
        movies: movies,
        featured: featured,
        category: category,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: MoviesStatus.error,
        errorMessage: 'Could not load movies. Check your connection.',
      ));
    }
  }
}
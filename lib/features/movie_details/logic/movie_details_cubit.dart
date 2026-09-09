import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/movie_details_repository.dart';
import '../data/models/movie_details_model.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRepository repository;

  MovieDetailsCubit(this.repository) : super(MovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());

    try {
      final movie = await repository.getMovieDetails(movieId);
      emit(MovieDetailsSuccess(movie));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movie;

  MovieDetailsSuccess(this.movie);
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}
part of 'home_movies_cubit.dart';

abstract class HomeMoviesState {}

class HomeMoviesInitial extends HomeMoviesState {}

class HomeMoviesLoading extends HomeMoviesState {}

class HomeMoviesLoaded extends HomeMoviesState {
  final List<MovieModel> movies;
  HomeMoviesLoaded(this.movies);
}

class HomeMoviesError extends HomeMoviesState {
  final String message;
  HomeMoviesError(this.message);
}
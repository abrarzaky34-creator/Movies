part of 'movies_bloc.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}
class HomeMoviesRequested extends MoviesEvent {
  const HomeMoviesRequested();
}
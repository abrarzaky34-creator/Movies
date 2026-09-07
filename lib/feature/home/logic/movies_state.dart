part of 'movies_bloc.dart';
enum MoviesStatus { initial, loading, loaded, error }
class MoviesState {
  final MoviesStatus status;
  final List<Movie> movies;
  final List<Movie> featured;
  final String? errorMessage;
  final String category;
  const MoviesState({
    this.status = MoviesStatus.initial,
    this.movies = const [],
    this.featured = const [],
    this.errorMessage,
    this.category = 'Action',
  });
  MoviesState copyWith({
    MoviesStatus? status,
    List<Movie>? movies,
    List<Movie>? featured,
    String? errorMessage,
    String? category,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      featured: featured ?? this.featured,
      errorMessage: errorMessage,
      category: category ?? this.category,
    );
  }
  Movie? get watchNowMovie => movies.isNotEmpty ? movies.first : null;
  List<Movie> get categoryMovies =>
      movies.where((m) => m.genres.contains(category)).toList();
}
part of 'browse_cubit.dart';

abstract class BrowseState {
  const BrowseState();
}

class BrowseInitial extends BrowseState {
  const BrowseInitial();
}

class BrowseLoading extends BrowseState {
  const BrowseLoading();
}

class BrowseSuccess extends BrowseState {
  final List<MovieModel> movies;
  final List<String> genres;

  const BrowseSuccess({
    required this.movies,
    required this.genres,
  });
}

class BrowseError extends BrowseState {
  final String message;

  const BrowseError(this.message);
}
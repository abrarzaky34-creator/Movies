import '../data/browse_service.dart';

abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseSuccessState extends BrowseState {
  final List<String> genres;
  final List<Movie> movies;

  BrowseSuccessState({
    required this.genres,
    required this.movies,
  });
}

class BrowseErrorState extends BrowseState {
  final String message;

  BrowseErrorState(this.message);
}
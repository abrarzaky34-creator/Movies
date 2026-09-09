import '../../data/models/movie_suggestions_model.dart';

abstract class SuggestionsState {}

class SuggestionsInitial extends SuggestionsState {}

class SuggestionsLoading extends SuggestionsState {}

class SuggestionsSuccess extends SuggestionsState {
  final List<MovieSuggestionModel> movies;

  SuggestionsSuccess(this.movies);
}

class SuggestionsError extends SuggestionsState {
  final String message;

  SuggestionsError(this.message);
}
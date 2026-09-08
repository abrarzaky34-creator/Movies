part of 'search_bloc.dart';
enum SearchStatus { initial, loading, loaded, empty, error }
class SearchState {
  final SearchStatus status;
  final String query;
  final List<Movie> results;
  final String? errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.results = const [],
    this.errorMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<Movie>? results,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      results: results ?? this.results,
      errorMessage: errorMessage,
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/movie.dart';
import '../data/movies_repository.dart';
part 'search_event.dart';
part 'search_state.dart';
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepository _repository;
  SearchBloc(this._repository) : super(const SearchState()) {
    on<SearchQueryChanged>(_onQueryChanged);
  }
  Future<void> _onQueryChanged(
      SearchQueryChanged event,
      Emitter<SearchState> emit,
      ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(state.copyWith(
        status: SearchStatus.initial,
        query: '',
        results: const [],
      ));
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading, query: query));

    try {
      final results = await _repository.searchMovies(query);
      emit(state.copyWith(
        status: results.isEmpty ? SearchStatus.empty : SearchStatus.loaded,
        results: results,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: SearchStatus.error,
        errorMessage: 'Could not search movies. Check your connection.',
      ));
    }
  }
}
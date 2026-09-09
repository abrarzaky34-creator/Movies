import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_source/movie_suggestion_data_source.dart';
import '../../data/models/movie_suggestions_model.dart';
import 'suggestions_state.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  final MovieSuggestionsDataSource dataSource;

  SuggestionsCubit(this.dataSource)
      : super(SuggestionsInitial());

  Future<void> getSuggestions(int movieId) async {
    emit(SuggestionsLoading());

    try {
      final List<MovieSuggestionModel> movies =
      await dataSource.getMovieSuggestions(movieId);

      emit(SuggestionsSuccess(movies));
    } catch (e) {
      emit(SuggestionsError(e.toString()));
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_source/history_data_source.dart';
import '../../data/models/history_model.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryDataSource dataSource;

  HistoryCubit(this.dataSource) : super(HistoryInitial());

  Future<void> getHistory() async {
    emit(HistoryLoading());

    try {
      final List<HistoryModel> movies =
      await dataSource.getHistory();

      emit(HistorySuccess(movies));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> addToHistory(HistoryModel movie) async {
    try {
      await dataSource.addToHistory(movie);

      await getHistory();
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> clearHistory() async {
    try {
      await dataSource.clearHistory();

      emit(HistorySuccess([]));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
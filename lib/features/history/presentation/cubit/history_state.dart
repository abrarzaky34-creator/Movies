import '../../data/models/history_model.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<HistoryModel> movies;

  HistorySuccess(this.movies);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
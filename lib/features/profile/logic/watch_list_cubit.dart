import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/watch_list_repository.dart';

abstract class WatchListState {}

class WatchListInitial extends WatchListState {}

class WatchListLoading extends WatchListState {}

class WatchListLoaded extends WatchListState {
  final List<Map<String, dynamic>> movies;

  WatchListLoaded(this.movies);
}

class WatchListError extends WatchListState {
  final String message;

  WatchListError(this.message);
}

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit({
    required this.repository,
  }) : super(WatchListInitial());

  final WatchListRepository repository;

  StreamSubscription<List<Map<String, dynamic>>>? _watchListSubscription;

  Future<void> addMovie({
    required int movieId,
    required String title,
    required String posterUrl,
  }) async {
    try {
      await repository.addMovie(
        movieId: movieId,
        title: title,
        posterUrl: posterUrl,
      );
    } catch (e) {
      emit(
        WatchListError(
          'Failed to add movie to watch list.',
        ),
      );
    }
  }

  Future<void> removeMovie(int movieId) async {
    try {
      await repository.removeMovie(movieId);
    } catch (e) {
      emit(
        WatchListError(
          'Failed to remove movie from watch list.',
        ),
      );
    }
  }

  void loadWatchList() {
    _watchListSubscription?.cancel();

    emit(WatchListLoading());

    _watchListSubscription = repository.getWatchList().listen(
          (movies) {
        emit(WatchListLoaded(movies));
      },
      onError: (error) {
        emit(
          WatchListError(
            'Failed to load watch list.',
          ),
        );
      },
    );
  }

  Future<bool> isMovieInWatchList(int movieId) async {
    try {
      return await repository.isMovieInWatchList(movieId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> close() async {
    await _watchListSubscription?.cancel();
    return super.close();
  }
}
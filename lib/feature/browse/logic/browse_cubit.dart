import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/browse_service.dart';
import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final BrowseService browseService;

  BrowseCubit(this.browseService)
      : super(BrowseInitialState());

  // All movies from API
  List<Movie> allMovies = [];

  // All unique genres
  List<String> categories = [];

  // Currently selected genre
  String selectedGenre = '';

  // Initialize Browse screen
  Future<void> initBrowseData() async {
    emit(BrowseLoadingState());

    try {
      // Get all movies
      allMovies = await browseService.fetchMovies();

      // Extract unique genres
      final genresSet =
      browseService.extractGenres(allMovies);

      // Convert Set to List
      categories = genresSet.toList();

      // Select first genre automatically
      if (categories.isNotEmpty) {
        selectedGenre = categories.first;

        // Filter movies by first genre
        final filteredMovies =
        browseService.filterMoviesByGenre(
          allMovies,
          selectedGenre,
        );

        emit(
          BrowseSuccessState(
            genres: categories,
            movies: filteredMovies,
          ),
        );
      } else {
        emit(
          BrowseSuccessState(
            genres: [],
            movies: [],
          ),
        );
      }
    } catch (e) {
      emit(
        BrowseErrorState(
          e.toString(),
        ),
      );
    }
  }

  // Change selected genre
  Future<void> changeGenre(String genre) async {
    selectedGenre = genre;

    try {
      // Filter locally from all movies
      final filteredMovies =
      browseService.filterMoviesByGenre(
        allMovies,
        genre,
      );

      emit(
        BrowseSuccessState(
          genres: categories,
          movies: filteredMovies,
        ),
      );
    } catch (e) {
      emit(
        BrowseErrorState(
          'Failed to filter movies: $e',
        ),
      );
    }
  }
}
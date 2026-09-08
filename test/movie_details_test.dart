import 'package:flutter_test/flutter_test.dart';
import 'package:movies/feature/movie_details/data/models/movie_details_model.dart';

void main() {
  test('MovieDetailsModel parses movie data correctly', () {
    final json = {
      'id': 123,
      'title': 'Test Movie',
      'description_full': 'This is a test movie.',
      'large_cover_image': 'https://example.com/cover.jpg',
      'background_image': 'https://example.com/background.jpg',
      'rating': 8.5,
      'runtime': 120,
      'genres': ['Action', 'Drama'],
    };

    final movie = MovieDetailsModel.fromJson(json);

    expect(movie.id, 123);
    expect(movie.title, 'Test Movie');
    expect(movie.description, 'This is a test movie.');
    expect(movie.largeCoverImage, 'https://example.com/cover.jpg');
    expect(movie.backgroundImage, 'https://example.com/background.jpg');
    expect(movie.rating, '8.5');
    expect(movie.runtime, 120);
    expect(movie.genres, ['Action', 'Drama']);
  });
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/movie_details_remote_data_source.dart';
import '../../data/movie_details_repository.dart';
import '../../logic/movie_details_cubit.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    final remoteDataSource = MovieDetailsRemoteDataSource(dio);

    final repository = MovieDetailsRepository(remoteDataSource);

    return BlocProvider(
      create: (context) =>
      MovieDetailsCubit(repository)..getMovieDetails(movieId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Details'),
        ),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MovieDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state is MovieDetailsSuccess) {
              final movie = state.movie;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (movie.largeCoverImage.isNotEmpty)
                      Image.network(
                        movie.largeCoverImage,
                        width: double.infinity,
                        height: 450,
                        fit: BoxFit.cover,
                      ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            '⭐ ${movie.rating}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Runtime: ${movie.runtime} minutes',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 12),

                          if (movie.genres.isNotEmpty)
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: movie.genres
                                  .map(
                                    (genre) => Chip(
                                  label: Text(genre),
                                ),
                              )
                                  .toList(),
                            ),

                          const SizedBox(height: 20),

                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            movie.description.isNotEmpty
                                ? movie.description
                                : 'No description available.',
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
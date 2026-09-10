import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/movie_details_remote_data_source.dart';
import '../../data/movie_details_repository.dart';
import '../../logic/movie_details_cubit.dart';

import '../../../../features/profile/data/watch_list_repository.dart';
import '../../../../features/profile/logic/watch_list_cubit.dart';

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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          MovieDetailsCubit(repository)..getMovieDetails(movieId),
        ),
        BlocProvider(
          create: (_) => WatchListCubit(
            repository: WatchListRepository(),
          ),
        ),
      ],
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

                          const SizedBox(height: 16),

                          _WatchListButton(
                            movieId: movie.id,
                            title: movie.title,
                            posterUrl: movie.largeCoverImage,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'â­گ ${movie.rating}',
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

class _WatchListButton extends StatefulWidget {
  const _WatchListButton({
    required this.movieId,
    required this.title,
    required this.posterUrl,
  });

  final int movieId;
  final String title;
  final String posterUrl;

  @override
  State<_WatchListButton> createState() => _WatchListButtonState();
}

class _WatchListButtonState extends State<_WatchListButton> {
  bool _isInWatchList = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkWatchList();
  }

  Future<void> _checkWatchList() async {
    final result = await context
        .read<WatchListCubit>()
        .isMovieInWatchList(widget.movieId);

    if (!mounted) return;

    setState(() {
      _isInWatchList = result;
      _isLoading = false;
    });
  }

  Future<void> _toggleWatchList() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final cubit = context.read<WatchListCubit>();

    try {
      if (_isInWatchList) {
        await cubit.removeMovie(widget.movieId);
      } else {
        await cubit.addMovie(
          movieId: widget.movieId,
          title: widget.title,
          posterUrl: widget.posterUrl,
        );
      }

      if (!mounted) return;

      setState(() {
        _isInWatchList = !_isInWatchList;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isInWatchList
                ? 'Added to Watch List'
                : 'Removed from Watch List',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _toggleWatchList,
        icon: _isLoading
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.black,
          ),
        )
            : Icon(
          _isInWatchList
              ? Icons.bookmark
              : Icons.bookmark_border,
        ),
        label: Text(
          _isInWatchList
              ? 'Remove from Watch List'
              : 'Add to Watch List',
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC107),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
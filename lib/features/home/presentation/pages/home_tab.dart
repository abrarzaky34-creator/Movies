import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../data/home_repository.dart';
import '../../data/data_source/home_remote_data_source.dart';
import '../cubit/home_movies_cubit.dart';
import '../../../movie_details/presentation/screens/movie_details_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeMoviesCubit(
        HomeRepository(HomeRemoteDataSource(Dio())),
      )..fetchMovies(),
      child: const _HomeTabBody(),
    );
  }
}

class _HomeTabBody extends StatelessWidget {
  const _HomeTabBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies'),
      ),
      body: BlocBuilder<HomeMoviesCubit, HomeMoviesState>(
        builder: (context, state) {
          if (state is HomeMoviesLoading || state is HomeMoviesInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeMoviesError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is HomeMoviesLoaded) {
            if (state.movies.isEmpty) {
              return const Center(child: Text('No movies found'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsScreen(movieId: movie.id),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            movie.coverImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('${movie.year} · ⭐ ${movie.rating}'),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/data_sources/browse_remote_data_source.dart';
import '../../data/repositories/browse_repository.dart';
import '../../logic/browse_cubit.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrowseCubit(
        BrowseRepository(
          BrowseRemoteDataSource(Dio()),
        ),
      )..getMovies(),
      child: const _BrowseView(),
    );
  }
}

class _BrowseView extends StatefulWidget {
  const _BrowseView();

  @override
  State<_BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<_BrowseView> {
  String selectedGenre = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Browse',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<BrowseCubit, BrowseState>(
        builder: (context, state) {
          if (state is BrowseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BrowseError) {
            return Center(
              child: Text(
                'Something went wrong.\n${state.message}',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.text),
              ),
            );
          }

          if (state is BrowseSuccess) {
            final genres = ['All', ...state.genres];

            final filteredMovies = selectedGenre == 'All'
                ? state.movies
                : state.movies
                .where(
                  (movie) => movie.genres.contains(selectedGenre),
            )
                .toList();

            return Column(
              children: [
                _buildGenreTabs(genres),
                const SizedBox(height: 20),
                Expanded(
                  child: filteredMovies.isEmpty
                      ? Center(
                    child: Text(
                      'No movies found for this genre.',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 16,
                      ),
                    ),
                  )
                      : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                movie.mediumCoverImage,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.card,
                                    child: const Center(
                                      child: Icon(
                                        Icons.movie,
                                        color: Colors.white54,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildGenreTabs(List<String> genres) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        separatorBuilder: (_, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final genre = genres[index];
          final isSelected = selectedGenre == genre;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedGenre = genre;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                genre,
                style: TextStyle(
                  color: isSelected
                      ? Colors.black
                      : AppColors.text,
                  fontSize: 14,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
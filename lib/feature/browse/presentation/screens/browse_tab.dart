import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/browse_cubit.dart';
import '../../logic/browse_state.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),

      appBar: AppBar(
        title: const Text(
          'Browse Category',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: BlocBuilder<BrowseCubit, BrowseState>(
        builder: (context, state) {
          // Initial
          if (state is BrowseInitialState) {
            return const Center(
              child: Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          // Loading
          if (state is BrowseLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFBB3B),
              ),
            );
          }

          // Error
          if (state is BrowseErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Success
          if (state is BrowseSuccessState) {
            final cubit = context.read<BrowseCubit>();

            return Column(
              children: [
                // =========================
                // GENRE TABS
                // =========================

                SizedBox(
                  height: 45,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),

                    itemCount: state.genres.length,

                    itemBuilder: (context, index) {
                      final genre = state.genres[index];

                      final isSelected =
                          genre == cubit.selectedGenre;

                      return GestureDetector(
                        onTap: () {
                          cubit.changeGenre(genre);
                        },

                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),

                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFFFBB3B)
                                : Colors.transparent,

                            borderRadius:
                            BorderRadius.circular(20),

                            border: Border.all(
                              color:
                              const Color(0xFFFFBB3B),
                            ),
                          ),

                          child: Center(
                            child: Text(
                              genre,

                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.white,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // =========================
                // MOVIES GRID
                // =========================

                Expanded(
                  child: state.movies.isEmpty
                      ? const Center(
                    child: Text(
                      'No movies found',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                      : GridView.builder(
                    padding:
                    const EdgeInsets.all(12),

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,

                      childAspectRatio: 0.62,

                      crossAxisSpacing: 12,

                      mainAxisSpacing: 12,
                    ),

                    itemCount:
                    state.movies.length,

                    itemBuilder:
                        (context, index) {
                      final movie =
                      state.movies[index];

                      return ClipRRect(
                        borderRadius:
                        BorderRadius.circular(8),

                        child: Image.network(
                          movie.coverImageUrl,

                          fit: BoxFit.cover,

                          errorBuilder:
                              (
                              context,
                              error,
                              stackTrace,
                              ) {
                            return Container(
                              color: const Color(
                                0xFF282A28,
                              ),

                              child: const Icon(
                                Icons.movie,
                                color:
                                Colors.white,
                                size: 40,
                              ),
                            );
                          },
                        ),
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
}
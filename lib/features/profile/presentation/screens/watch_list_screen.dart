import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../data/watch_list_repository.dart';
import '../../logic/watch_list_cubit.dart';
import '../widgets/watch_list_item.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchListCubit(
        repository: WatchListRepository(),
      )..loadWatchList(),
      child: const _WatchListView(),
    );
  }
}

class _WatchListView extends StatelessWidget {
  const _WatchListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Watch List',
                          style: TextStyle(
                            color: Color(0xFFFFC107),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 2,
                          width: 80,
                          color: const Color(0xFFFFC107),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Expanded(
              child: BlocBuilder<WatchListCubit, WatchListState>(
                builder: (context, state) {
                  if (state is WatchListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFC107),
                      ),
                    );
                  }

                  if (state is WatchListError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (state is WatchListLoaded) {
                    if (state.movies.isEmpty) {
                      return Center(
                        child: Image.asset(
                          'assets/images/empty_list.png',
                          width: 180,
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 4,
                      ),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 16,
                        childAspectRatio: 122 / 179.58,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        final movieId =
                            (movie['movieId'] as num?)?.toInt() ?? 0;

                        final posterUrl =
                            movie['posterUrl'] as String? ?? '';

                        return GestureDetector(
                          onTap: () {
                            if (movieId == 0) return;

                            Navigator.pushNamed(
                              context,
                              AppRoutes.movieDetails,
                              arguments: movieId,
                            );
                          },
                          onLongPress: () {
                            if (movieId == 0) return;

                            showDialog<void>(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF242424),
                                  title: const Text(
                                    'Remove from Watch List?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: const Text(
                                    'Do you want to remove this movie from your watch list?',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);

                                        context
                                            .read<WatchListCubit>()
                                            .removeMovie(movieId);
                                      },
                                      child: const Text(
                                        'Remove',
                                        style: TextStyle(
                                          color: Color(0xFFFFC107),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: WatchListItem(
                            posterUrl: posterUrl,
                            rating: 0,
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
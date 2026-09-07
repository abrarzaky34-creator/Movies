import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/models/movie.dart';
import '../../data/movies_repository.dart';
import '../../logic/movies_bloc.dart';
import '../widgets/available_now_slider.dart';
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoviesBloc(MoviesRepository(DioClient.create()))
        ..add(const HomeMoviesRequested()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          title: const Text('Movies'),
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case MoviesStatus.loading:
              case MoviesStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              case MoviesStatus.error:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.errorMessage ?? 'Something went wrong',
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context
                            .read<MoviesBloc>()
                            .add(const HomeMoviesRequested()),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              case MoviesStatus.loaded:
                return _HomeContent(state: state);
            }
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final MoviesState state;
  const _HomeContent({required this.state});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        _AvailableNowHero(movies: state.featured),
        const SizedBox(height: 16),
        _CategoryRow(
          title: state.category,
          movies: state.categoryMovies,
          onSeeMore: () {
          },
        ),
      ],
    );
  }
}
class _AvailableNowHero extends StatefulWidget {
  final List<Movie> movies;
  const _AvailableNowHero({required this.movies});

  @override
  State<_AvailableNowHero> createState() => _AvailableNowHeroState();
}

class _AvailableNowHeroState extends State<_AvailableNowHero> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) return const SizedBox.shrink();
    final featured = widget.movies[_currentIndex];
    final posterUrls = widget.movies.map((m) => m.coverImageUrl).toList();
    final ratings = widget.movies.map((m) => m.rating).toList();

    return SizedBox(
      width: double.infinity,
      height: 645.h,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: featured.backgroundImageUrl.isEmpty
                ? Container(color: AppColors.background)
                : CachedNetworkImage(
              key: ValueKey(featured.id),
              imageUrl: featured.backgroundImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: AppColors.background.withValues(alpha: 0.82)),
          ),
          Positioned(
            top: 7.h,
            left: 81.w,
            child: Image.asset(
              'assets/images/available_now.png',
              width: 267.w,
              height: 93.h,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 121.h,
            left: 0,
            right: 0,
            child: AvailableNowSlider(
              imageUrls: posterUrls,
              ratings: ratings,
              onPageChanged: (index) => setState(() => _currentIndex = index),
            ),
          ),
          Positioned(
            top: 493.h,
            left: 38.w,
            child: Image.asset(
              'assets/images/watch_now.png',
              width: 354.w,
              height: 146.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: AppColors.primary, size: 14),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(color: AppColors.text, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final VoidCallback onSeeMore;

  const _CategoryRow({
    required this.title,
    required this.movies,
    required this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onSeeMore,
                child: const Text(
                  'See More →',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: movies[index].coverImageUrl,
                    width: 120,
                    height: 180,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.card),
                    errorWidget: (_, __, ___) =>
                        Container(color: AppColors.card),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: _RatingBadge(rating: movies[index].rating),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
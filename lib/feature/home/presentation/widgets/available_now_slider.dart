import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/constants/app_colors.dart';

class AvailableNowSlider extends StatelessWidget {
  final List<String> imageUrls;
  final List<double> ratings;
  final ValueChanged<int> onPageChanged;

  const AvailableNowSlider({
    super.key,
    required this.imageUrls,
    required this.ratings,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 351.h,
      child: CarouselSlider.builder(
        itemCount: imageUrls.length,
        options: CarouselOptions(
          height: 351.h,
          viewportFraction: 234 / 430,
          enlargeCenterPage: true,
          enlargeFactor: 0.21,
          padEnds: true,
          onPageChanged: (index, reason) => onPageChanged(index),
        ),
        itemBuilder: (context, index, realIndex) {
          return _MovieCarouselItem(
            imageUrl: imageUrls[index],
            rating: ratings[index],
          );
        },
      ),
    );
  }
}

class _MovieCarouselItem extends StatelessWidget {
  final String imageUrl;
  final double rating;

  const _MovieCarouselItem({
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 234.w,
      height: 351.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 12.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.card),
              errorWidget: (_, __, ___) => Container(color: AppColors.card),
            ),
            Positioned(
              top: 10.h,
              left: 10.w,
              child: _SliderRatingBadge(rating: rating),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderRatingBadge extends StatelessWidget {
  final double rating;

  const _SliderRatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              color: AppColors.text,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 3.w),
          Icon(
            Icons.star,
            color: AppColors.primary,
            size: 12.sp,
          ),
        ],
      ),
    );
  }
}
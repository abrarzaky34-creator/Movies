import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BrowseTabPlaceholder extends StatelessWidget {
  const BrowseTabPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Text(
          'Browse Screen',
          style: TextStyle(color: AppColors.text, fontSize: 16),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
/// TODO(teammate): replace with the real search bar + results UI.
class SearchTabPlaceholder extends StatelessWidget {
  const SearchTabPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Text(
          'Search Screen',
          style: TextStyle(color: AppColors.text, fontSize: 16),
        ),
      ),
    );
  }
}
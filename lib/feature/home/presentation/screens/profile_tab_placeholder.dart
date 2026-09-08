import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileTabPlaceholder extends StatelessWidget {
  const ProfileTabPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(color: AppColors.text, fontSize: 16),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 61,
        margin: const EdgeInsets.only(left: 9, right: 9, bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF282A28),
          borderRadius: BorderRadius.circular(16),
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.secondaryText,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: _navIcon('assets/icons/home.png', selected: false),
                activeIcon: _navIcon('assets/icons/home.png', selected: true),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _navIcon('assets/icons/search.png', selected: false),
                activeIcon: _navIcon('assets/icons/search.png', selected: true),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: _navIcon('assets/icons/browse.png', selected: false),
                activeIcon: _navIcon('assets/icons/browse.png', selected: true),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: _navIcon('assets/icons/profile.png', selected: false),
                activeIcon: _navIcon('assets/icons/profile.png', selected: true),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navIcon(String assetPath, {required bool selected}) {
    return Image.asset(
      assetPath,
      width: 24,
      height: 24,
      color: selected ? AppColors.primary : AppColors.secondaryText,
    );
  }
}
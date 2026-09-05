import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'home_tab.dart';
import 'search_tab_placeholder.dart';
import 'browse_tab_placeholder.dart';
import 'profile_tab_placeholder.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  static const List<Widget> _tabs = [
    HomeTab(),
    SearchTabPlaceholder(),
    BrowseTabPlaceholder(),
    ProfileTabPlaceholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: _tabs,
          ),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<HomeCubit>().changeTab(index),
          ),
        );
      },
    );
  }
}
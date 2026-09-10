import 'package:flutter/material.dart';
import 'package:movies/feature/auth/presentation/screens/splash_screen.dart';
import 'package:movies/feature/auth/presentation/screens/login_screen.dart';
import 'package:movies/feature/auth/presentation/screens/register_screen.dart';
import 'package:movies/feature/auth/presentation/screens/forget_password_screen.dart';
import 'package:movies/feature/auth/presentation/screens/update_profile_screen.dart';
import 'package:movies/feature/auth/presentation/screens/profile_tab.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String updateProfile = '/update-profile';
  static const String profileTab = '/profile-tab';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    forgetPassword: (context) => const ForgetPasswordScreen(),
    updateProfile: (context) => const UpdateProfileScreen(),
    profileTab: (context) => const ProfileTab(),
  };
}
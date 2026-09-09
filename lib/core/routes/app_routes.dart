<<<<<<< Updated upstream
=======
import 'package:flutter/material.dart';
import 'package:movies/feature/auth/presentation/screens/splash_screen.dart';
import 'package:movies/feature/auth/presentation/screens/onboarding_screen_1.dart';
import 'package:movies/feature/auth/presentation/screens/login_screen.dart';
import 'package:movies/feature/auth/presentation/screens/register_screen.dart';
import 'package:movies/feature/auth/presentation/screens/forget_password_screen.dart';
import 'package:movies/feature/auth/presentation/screens/update_profile_screen.dart';
import 'package:movies/feature/auth/presentation/screens/profile_tab.dart';

import '../../feature/auth/presentation/screens/onboarding _screen_2.dart';

>>>>>>> Stashed changes
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
<<<<<<< Updated upstream
  static const String home = '/home';
  static const String movieDetails = '/movie-details';
  static const String search = '/search';
  static const String browse = '/browse';
  static const String profile = '/profile';
=======
  static const String forgetPassword = '/forget-password';
  static const String profileTab = '/profile-tab';
  static const String updateProfile = '/update-profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case profileTab:
        return MaterialPageRoute(builder: (_) => const ProfileTab());

      case updateProfile:
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
>>>>>>> Stashed changes
}
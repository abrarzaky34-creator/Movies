import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen_1.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forget_password_screen.dart';
import '../../features/auth/presentation/screens/update_profile_screen.dart';
import '../../features/auth/presentation/screens/profile_tab.dart';
import '../../features/home/presentation/pages/main_layout_screen.dart';
import '../../features/movie_details/presentation/screens/movie_details_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String home = '/home';
  static const String profileTab = '/profile-tab';
  static const String updateProfile = '/update-profile';
  static const String movieDetails = '/movie-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());

      case profileTab:
        return MaterialPageRoute(builder: (_) => const ProfileTab());

      case updateProfile:
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());

      case movieDetails:
        final movieId = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(movieId: movieId),
        );

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
}
import 'package:flutter/material.dart';
import '../../feature/auth/presentation/screens/splash_screen.dart';
import '../../feature/auth/presentation/screens/onboarding_screen_1.dart';
import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/auth/presentation/screens/register_screen.dart';
import '../../feature/auth/presentation/screens/forget_password_screen.dart';
import '../../feature/auth/presentation/screens/update_profile_screen.dart';
import '../../feature/auth/presentation/screens/profile_tab.dart';
import '../../features/home/presentation/pages/main_layout_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String home = '/home';
  static const String profileTab = '/profile-tab';
  static const String updateProfile = '/update-profile';

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
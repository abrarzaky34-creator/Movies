import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'feature/auth/data/auth_service.dart';
import 'feature/auth/logic/auth_cubit.dart';

// Auth Screens
import 'feature/auth/presentation/screens/splash_screen.dart';
import 'feature/auth/presentation/screens/login_screen.dart';
import 'feature/auth/presentation/screens/register_screen.dart';
import 'feature/auth/presentation/screens/forget_password_screen.dart';

// Main App Screens (من شغلها هي)
import 'features/home/presentation/pages/home_tab.dart';
import 'features/home/presentation/pages/main_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        theme: AppTheme.darkTheme,

        // الشاشة اللي بيفتح عليها الابلكيشن الأول
        home: const SplashScreen(),

        // خريطة التنقل الكاملة بين كل شاشات المشروع
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/forget_password': (context) => const ForgetPasswordScreen(),
          '/home': (context) => const HomeTab(),
          '/main_layout': (context) => const MainLayoutScreen(),
        },
      ),
    );
  }
}
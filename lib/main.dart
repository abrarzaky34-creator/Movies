import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'feature/auth/presentation/screens/splash_screen.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/auth/data/auth_service.dart';
import 'feature/auth/logic/auth_cubit.dart';
import 'feature/auth/presentation/screens/forget_password_screen.dart';
import 'feature/auth/presentation/screens/login_screen.dart';
import 'feature/auth/presentation/screens/register_screen.dart';
>>>>>>> Stashed changes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
=======
    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        theme: ThemeData.dark(),
        home: const LoginScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/forget_password': (context) => const ForgetPasswordScreen(),
        },
      ),
>>>>>>> Stashed changes
    );
  }
}
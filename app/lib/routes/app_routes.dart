import 'package:flutter/material.dart';
import 'package:shoppe/home/home_screen.dart';
import 'package:shoppe/auth/login_screen.dart';
import 'package:shoppe/auth/create_account_screen.dart';
import 'package:shoppe/profile/profile_screen.dart';
import 'package:shoppe/onboarding/onboarding_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String onboarding = '/onboarding';
  static const String createAccount = '/create-account';
  static const String password = '/password';

  static Map<String, WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingScreen(),
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    profile: (context) => const ProfileScreen(),
    createAccount: (context) => const CreateAccountScreen(),

    // Note: PasswordScreen requires parameters, so it's navigated to directly
  };
}

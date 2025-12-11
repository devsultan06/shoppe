import 'package:flutter/material.dart';
import 'package:first_app/home/home_screen.dart';
import 'package:first_app/login/login_screen.dart';
import 'package:first_app/profile/profile_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    profile: (context) => const ProfileScreen(),
  };
}

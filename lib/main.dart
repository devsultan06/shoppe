import 'package:flutter/material.dart';
import 'package:shoppe/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login, // First screen
      routes: AppRoutes.routes, // Centralized route map
    );
  }
}

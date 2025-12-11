import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      initialRoute: AppRoutes.onboarding, // First screen
      routes: AppRoutes.routes, // Centralized route map
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
        // Also set the primary text theme for app bars and other components
        primaryTextTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).primaryTextTheme,
        ),
        // Set default font family
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
    );
  }
}

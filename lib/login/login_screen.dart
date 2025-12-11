import 'package:flutter/material.dart';
import 'package:shoppe/routes/app_routes.dart'; // Import your routes

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color(0xFF6200EE),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Home screen
            Navigator.pushNamed(context, AppRoutes.home);
          },
          child: const Text("Go to Home"),
        ),
      ),
    );
  }
}

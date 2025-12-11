import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // Background bubbles
          Positioned(
            top: -100,
            left: -100,
            child: Image.asset(
              'assets/images/l1.png',
              width: 300,
              height: 400,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: -50,
            right: -80,
            child: Image.asset(
              'assets/images/l2.png',
              width: 200,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: -50,
            right: -60,
            child: Image.asset(
              'assets/images/l3.png',
              width: 180,
              height: 220,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: -30,
            left: -50,
            child: Image.asset(
              'assets/images/l4.png',
              width: 150,
              height: 180,
              fit: BoxFit.contain,
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),

                  // Title
                  Text(
                    'Login',
                    style: GoogleFonts.raleway(
                      fontSize: 52,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF202020),
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Subtitle with heart emoji
                  Row(
                    children: [
                      Text(
                        'Good to see you back!',
                        style: GoogleFonts.raleway(
                          fontSize: 19,
                          color: const Color(0xFF7A7A7A),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('🖤', style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 17),

                  // Email field
                  TextField(
                    controller: _emailController,
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: const Color(0xFF202020),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.raleway(
                        fontSize: 16,
                        color: const Color(0xFFB0B0B0),
                        fontWeight: FontWeight.w300,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8F8F8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(59),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(59),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(59),
                        borderSide: const BorderSide(
                          color: Color(0xFF004CFF),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),

          // Absolutely positioned buttons at bottom
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 61,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Home screen
                      Navigator.pushNamed(context, AppRoutes.home);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004CFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFFF3F3F3),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Cancel button
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF202020),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

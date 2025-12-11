import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo section
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 134,
                    height: 134,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Shoppe',
                style: GoogleFonts.raleway(
                  fontSize: 52,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF202020),
                  letterSpacing: -0.52,
                ),
              ),
              const SizedBox(height: 18),

              // Subtitle
              Text(
                'Beautiful eCommerce UI Kit\nfor your online store',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontSize: 19,
                  color: const Color(0xFF202020),
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 106),

              // Primary button
              SizedBox(
                width: double.infinity,
                height: 61,
                child: ElevatedButton(
                  onPressed: () {
                    print("Let's get started button pressed!");
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
                    "Let's get started",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Secondary button with icon
              SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  onPressed: () {
                    print("I already have an account button pressed!");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I already have an account',
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF202020),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/images/Button.svg',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
            top: -140,
            left: 0,
            child: Image.asset(
              'assets/images/bub1.png',
              width: 311,
              height: 367,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 30,
            right: -90,
            child: Image.asset(
              'assets/images/bub2.png',
              width: 243,
              height: 266,
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
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    'Create\nAccount',
                    style: GoogleFonts.raleway(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF202020),
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 54),

                  // Profile photo upload section
                  GestureDetector(
                    onTap: () {
                      print("Upload photo tapped!");
                    },
                    child: Image.asset(
                      'assets/images/upload.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 32),

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

                  const SizedBox(height: 10),

                  // Password field
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: const Color(0xFF202020),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFFB0B0B0),
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Phone number field with country selector
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Row(
                      children: [
                        // Country selector
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/logo.png', // Using logo as flag placeholder
                              width: 24,
                              height: 16,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFFB0B0B0),
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 20,
                          color: const Color(0xFFE0E0E0),
                        ),
                        const SizedBox(width: 12),
                        // Phone number field
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              color: const Color(0xFF202020),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Your number',
                              hintStyle: GoogleFonts.raleway(
                                fontSize: 16,
                                color: const Color(0xFFB0B0B0),
                                fontWeight: FontWeight.w300,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
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
                // Done button
                SizedBox(
                  width: double.infinity,
                  height: 61,
                  child: ElevatedButton(
                    onPressed: () {
                      print("Done button pressed!");
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
                      "Done",
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

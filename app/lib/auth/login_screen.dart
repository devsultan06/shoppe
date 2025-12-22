import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/widgets/top-toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Method to handle login
  void _handleLogin() async {
    // Prevent multiple submissions
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Get value from email controller
      String email = _emailController.text.trim();

      // Basic validation
      if (email.isEmpty) {
        TopToast.show(
          context,
          message: 'Please enter your email',
          type: ToastType.error,
        );
        return;
      }

      // Create login data object
      Map<String, dynamic> loginData = {'email': email};

      // Print the data (you can replace this with your API call)
      print('Login Data to send to backend:');
      print('Email: $email');
      print('Full object: $loginData');

      // Send to backend
      await _sendLoginToBackend(loginData);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to send login data to backend
  Future<void> _sendLoginToBackend(Map<String, dynamic> loginData) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with your actual API endpoint
      // Example:
      // final response = await http.post(
      //   Uri.parse('https://your-api.com/auth/login'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(loginData),
      // );
      //
      // if (response.statusCode == 200) {
      //   // Success - navigate to home screen
      //   Navigator.pushNamed(context, AppRoutes.home);
      // } else {
      //   _showErrorMessage('Login failed');
      // }

      // For now, just simulate success and navigate
      TopToast.show(
        context,
        message: 'Login successful!',
        type: ToastType.success,
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, '/home'); // Update with your actual route
      });
    } catch (e) {
      TopToast.show(
        context,
        message: 'Error during login: $e',
        type: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // Background bubbles
          Positioned(
            top: -50,
            left: -50,
            child: Image.asset(
              'assets/images/l2.png',
              width: 373,
              height: 442,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: -120,
            left: -120,
            child: Image.asset(
              'assets/images/l1.png',
              width: 402,
              height: 442,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            bottom: -100,
            right: -70,
            child: Image.asset(
              'assets/images/l3.png',
              width: 373,
              height: 442,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 250,
            right: -30,
            child: Image.asset(
              'assets/images/l4.png',
              width: 137,
              height: 151,
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
                          color: const Color(0xFF202020),
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
                    onPressed: _isLoading
                        ? null
                        : () {
                            _handleLogin();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isLoading
                          ? const Color(0xFF9AA5B1)
                          : const Color(0xFF004CFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Logging in...",
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFFF3F3F3),
                                ),
                              ),
                            ],
                          )
                        : Text(
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

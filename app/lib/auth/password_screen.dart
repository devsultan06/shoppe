import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/widgets/top-toast.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  final String profileImageUrl;

  const PasswordScreen({
    super.key,
    required this.email,
    this.profileImageUrl = '',
  });

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _password = '';
  List<bool> _filledCircles = List.filled(8, false);

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _password = value;
      // Update filled circles based on password length
      for (int i = 0; i < _filledCircles.length; i++) {
        _filledCircles[i] = i < value.length;
      }
    });
  }

  // Method to handle password submission
  void _handlePasswordSubmit() async {
    // Prevent multiple submissions
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String password = _passwordController.text.trim();

      // Basic validation
      if (password.isEmpty) {
        TopToast.show(
          context,
          message: 'Please enter your password',
          type: ToastType.error,
        );
        return;
      }

      if (password.length < 6) {
        TopToast.show(
          context,
          message: 'Password must be at least 6 characters',
          type: ToastType.error,
        );
        return;
      }

      // Create login data object
      Map<String, dynamic> loginData = {
        'email': widget.email,
        'password': password,
      };

      // Print the data (you can replace this with your API call)
      print('Complete Login Data to send to backend:');
      print('Email: ${widget.email}');
      print('Password: $password');
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
          // Background bubbles - same as login screen
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),

                  // Profile picture
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: widget.profileImageUrl.isNotEmpty
                          ? Image.network(
                              widget.profileImageUrl,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: const Color(0xFFE8BBE8),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Greeting
                  Text(
                    'Hello, Romina!!',
                    style: GoogleFonts.raleway(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF202020),
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Instruction text
                  Text(
                    'Type your password',
                    style: GoogleFonts.raleway(
                      fontSize: 19,
                      color: const Color(0xFF202020),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Password circles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(8, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _filledCircles[index]
                              ? const Color(0xFF004CFF)
                              : const Color(0xFFE5E5E5),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 40),

                  // Hidden password field
                  Opacity(
                    opacity: 0.0,
                    child: TextField(
                      controller: _passwordController,
                      onChanged: _onPasswordChanged,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      style: const TextStyle(color: Colors.transparent),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),
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
                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 61,
                  child: ElevatedButton(
                    onPressed: _isLoading || _password.length < 6
                        ? null
                        : () {
                            _handlePasswordSubmit();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isLoading || _password.length < 6
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
                            "Continue",
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFFF3F3F3),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // Back button
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back',
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

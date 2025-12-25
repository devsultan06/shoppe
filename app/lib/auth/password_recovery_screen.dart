import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/widgets/top-toast.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  bool _isSmsSelected = true;
  bool _isLoading = false;

  // Method to handle recovery option selection
  void _handleRecoverySubmit() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      String method = _isSmsSelected ? 'SMS' : 'Email';

      TopToast.show(
        context,
        message: 'Recovery code sent via $method!',
        type: ToastType.success,
      );

      // Navigate to verification screen
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(
          context,
          '/verify',
        ); // Update with your actual route
      });
    } catch (e) {
      TopToast.show(
        context,
        message: 'Error sending recovery code: $e',
        type: ToastType.error,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildOptionButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    // Define colors based on the option type
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Color checkColor;

    if (title == 'SMS') {
      backgroundColor = isSelected
          ? const Color(0xFF004CFF).withOpacity(0.1) // Light blue
          : const Color(0xFF004CFF).withOpacity(0.05); // Very light blue
      borderColor = const Color(0xFF004CFF);
      textColor = const Color(0xFF004CFF);
      checkColor = const Color(0xFF004CFF);
    } else {
      // Email
      backgroundColor = isSelected
          ? const Color(0xFFFF6B9D).withOpacity(0.1) // Light pink
          : const Color(0xFFFF6B9D).withOpacity(0.05); // Very light pink
      borderColor = isSelected
          ? const Color(0xFFFF6B9D)
          : const Color(0xFFFF6B9D).withOpacity(0.3);
      textColor = const Color(0xFF202020);
      checkColor = const Color(0xFFFF6B9D);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Text(
              title,
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? checkColor : Colors.transparent,
                border: Border.all(color: checkColor, width: 2),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // Background bubbles - same as login screen
          Positioned(
            top: -120,
            right: -50,
            child: Image.asset(
              'assets/images/p2.png',
              width: 373,
              height: 442,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: -160,
            right: -120,
            child: Image.asset(
              'assets/images/p1.png',
              width: 402,
              height: 442,
              fit: BoxFit.contain,
            ),
          ),

          // Back button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Color(0xFF202020),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

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
                      child: Container(
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

                  // Title
                  Text(
                    'Password Recovery',
                    style: GoogleFonts.raleway(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF202020),
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'How you would like to restore\nyour password?',
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      color: const Color(0xFF202020),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // Recovery options
                  _buildOptionButton(
                    title: 'SMS',
                    isSelected: _isSmsSelected,
                    onTap: () {
                      setState(() {
                        _isSmsSelected = true;
                      });
                    },
                  ),

                  _buildOptionButton(
                    title: 'Email',
                    isSelected: !_isSmsSelected,
                    onTap: () {
                      setState(() {
                        _isSmsSelected = false;
                      });
                    },
                  ),

                  const Spacer(flex: 3),
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
                            _handleRecoverySubmit();
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
                                "Sending...",
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

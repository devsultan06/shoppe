import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/widgets/top-toast.dart';
import 'package:shoppe/widgets/loading_overlay.dart';

class VerifyScreen extends StatefulWidget {
  final String email;
  final String profileImageUrl;

  const VerifyScreen({
    super.key,
    required this.email,
    this.profileImageUrl = '',
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool _isLoading = false;
  List<String> _otpDigits = List.filled(4, '');
  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onNumberTap(String number) {
    // Find the first empty box
    for (int i = 0; i < _otpDigits.length; i++) {
      if (_otpDigits[i].isEmpty) {
        setState(() {
          _otpDigits[i] = number;
          _controllers[i].text = number;
        });
        // Move to next box or unfocus if last box
        if (i < _otpDigits.length - 1) {
          _focusNodes[i + 1].requestFocus();
        } else {
          _focusNodes[i].unfocus();
          // Auto-verify when 4 digits are complete
          _handleAutoVerify();
        }
        break;
      }
    }
  }

  // Auto-verify when 4 digits are entered
  void _handleAutoVerify() async {
    if (_otpCode.length == 4) {
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Small delay for UX
      _performVerification();
    }
  }

  // Method to perform verification
  void _performVerification() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String otpCode = _otpCode;

      // Dummy validation - check if code is 1234
      if (otpCode == '1234') {
        // Success - simulate network delay then navigate to home
        await Future.delayed(const Duration(seconds: 2));

        TopToast.show(
          context,
          message: 'Verification successful!',
          type: ToastType.success,
        );

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(
            context,
            '/home',
          ); // Update with your actual route
        });
      } else {
        // Failed - show error and reset
        await Future.delayed(const Duration(seconds: 1));

        TopToast.show(
          context,
          message: 'Invalid code. Please try again.',
          type: ToastType.error,
        );

        // Clear the OTP boxes
        setState(() {
          _otpDigits = List.filled(4, '');
          for (var controller in _controllers) {
            controller.clear();
          }
        });

        // Focus on first box
        _focusNodes[0].requestFocus();
      }
    } catch (e) {
      TopToast.show(
        context,
        message: 'Error during verification: $e',
        type: ToastType.error,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onBackspace() {
    // Find the last filled box and clear it
    for (int i = _otpDigits.length - 1; i >= 0; i--) {
      if (_otpDigits[i].isNotEmpty) {
        setState(() {
          _otpDigits[i] = '';
          _controllers[i].text = '';
        });
        _focusNodes[i].requestFocus();
        break;
      }
    }
  }

  String get _otpCode => _otpDigits.join('');

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberTap(number),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
        ),
        child: Center(
          child: Text(
            number,
            style: GoogleFonts.raleway(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF202020),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return GestureDetector(
      onTap: _onBackspace,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 24,
            color: Color(0xFF202020),
          ),
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
                    padding: EdgeInsets.only(left: 8.0),
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
                  const Spacer(flex: 4), // Profile picture
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
                    'Enter verification code',
                    style: GoogleFonts.raleway(
                      fontSize: 19,
                      color: const Color(0xFF202020),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // OTP input boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _otpDigits[index].isNotEmpty
                                ? const Color(0xFF004CFF)
                                : const Color(0xFFE5E5E5),
                            width: 2,
                          ),
                          color: _otpDigits[index].isNotEmpty
                              ? const Color(0xFF004CFF).withOpacity(0.1)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            _otpDigits[index],
                            style: GoogleFonts.raleway(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF202020),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 40),

                  // Number pad
                  Container(
                    width: 320,
                    child: Column(
                      children: [
                        // Row 1: 1, 2, 3, 4
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNumberButton('1'),
                            _buildNumberButton('2'),
                            _buildNumberButton('3'),
                            _buildNumberButton('4'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Row 2: 5, 6, 7, 8
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNumberButton('5'),
                            _buildNumberButton('6'),
                            _buildNumberButton('7'),
                            _buildNumberButton('8'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Row 3: empty, 9, 0, backspace
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 60,
                              height: 60,
                            ), // Empty space
                            _buildNumberButton('9'),
                            _buildNumberButton('0'),
                            _buildBackspaceButton(),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            AnimatedLoadingOverlay(
              message: 'Verifying code...',
              isVisible: _isLoading,
            ),
        ],
      ),
    );
  }
}

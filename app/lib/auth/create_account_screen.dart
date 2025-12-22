import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shoppe/widgets/top-toast.dart';

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
  bool _isLoading = false;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Method to pick image from gallery or camera
  Future<void> _pickImage() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text('Cancel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      TopToast.show(
        context,
        message: 'Error opening image picker: $e',
        type: ToastType.error,
      );
    }
  }

  // Method to get image from selected source
  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        TopToast.show(
          context,
          message: 'Profile photo selected successfully!',
          type: ToastType.success,
        );
      }
    } catch (e) {
      TopToast.show(
        context,
        message: 'Error picking image: $e',
        type: ToastType.error,
      );
    }
  }

  // Method to handle form submission
  void _handleCreateAccount() async {
    // Prevent multiple submissions
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Get values from text controllers
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String phoneNumber = _phoneController.text.trim();

      // Basic validation
      if (email.isEmpty) {
        TopToast.show(
          context,
          message: 'Please enter your email',
          type: ToastType.error,
        );
        return;
      }

      if (password.isEmpty) {
        TopToast.show(
          context,
          message: 'Please enter your password',
          type: ToastType.error,
        );
        return;
      }

      if (phoneNumber.isEmpty) {
        TopToast.show(
          context,
          message: 'Please enter your phone number',
          type: ToastType.error,
        );
        return;
      }

      // Create user data object
      Map<String, dynamic> userData = {
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'profileImage': _selectedImage?.path, // Include the image path
      };

      // Print the data (you can replace this with your API call)
      print('User Data to send to backend:');
      print('Email: $email');
      print('Password: $password');
      print('Phone: $phoneNumber');
      print('Profile Image: ${_selectedImage?.path ?? 'No image selected'}');
      print('Full object: $userData');

      // Send to backend
      await _sendToBackend(userData);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to send data to backend
  Future<void> _sendToBackend(Map<String, dynamic> userData) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with your actual API endpoint
      // Example:
      // final response = await http.post(
      //   Uri.parse('https://your-api.com/auth/register'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(userData),
      // );
      //
      // if (response.statusCode == 200) {
      //   // Success - navigate to next screen
      //   Navigator.pushNamed(context, AppRoutes.login);
      // } else {
      //   _showErrorMessage('Registration failed');
      // }

      // For now, just simulate success
      TopToast.show(
        context,
        message: 'Account created successfully',
        type: ToastType.success,
      );
    } catch (e) {
      TopToast.show(
        context,
        message: 'Error creating account: $e',
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
                      _pickImage();
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedImage != null
                            ? Colors.transparent
                            : const Color(0xFFF8F8F8),
                        border: Border.all(
                          color: const Color(0xFF004CFF),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: _selectedImage != null
                          ? ClipOval(
                              child: Image.file(
                                _selectedImage!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Image.asset(
                                'assets/images/upload.png',
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                              ),
                            ),
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
                    onPressed: _isLoading
                        ? null
                        : () {
                            _handleCreateAccount();
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
                                "Creating Account...",
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFFF3F3F3),
                                ),
                              ),
                            ],
                          )
                        : Text(
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

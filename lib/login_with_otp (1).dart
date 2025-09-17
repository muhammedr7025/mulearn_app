// Enhanced login_with_otp.dart - Replace your existing file with this
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mu/forgot_password.dart';
import 'package:mu/login_page%20(1).dart';
import 'package:mu/signup_page.dart';
import 'package:mu/widgets/animate.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginWithOtPage extends StatefulWidget {
  const LoginWithOtPage({super.key});

  @override
  State<LoginWithOtPage> createState() => _LoginWithOtPageState();
}

class _LoginWithOtPageState extends State<LoginWithOtPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // Replace the OTP handler methods in your LoginWithOtPage

  void _handleRequestOTP() async {
    if (_formKey.currentState!.validate()) {
      try {
        final success = await context.read<AuthProvider>().requestOTP(
          _emailController.text.trim(),
        );

        if (!mounted) return;

        if (success) {
          setState(() {
            _otpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'OTP sent successfully! Check your email/phone.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 14),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to send OTP. Please try again.',
                style: GoogleFonts.plusJakartaSans(fontSize: 14),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      }
    }
  }

  void _handleVerifyOTP() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<AuthProvider>().verifyOTPLogin(
          _emailController.text.trim(),
          _otpController.text.trim(),
        );

        if (!mounted) return;

        // Check if OTP verification was successful
        final authProvider = context.read<AuthProvider>();
        if (authProvider.state == AuthState.authenticated &&
            authProvider.user != null) {
          // Success! The AuthInitializer will automatically handle navigation
          // No manual navigation needed - your existing setup will handle it
          print(
            '✅ OTP verification successful - AuthInitializer will handle navigation',
          );
        } else if (authProvider.state == AuthState.error) {
          // Error will be displayed by the Consumer<AuthProvider> widget automatically
          print('❌ OTP verification failed - error will be displayed');
        }
      } catch (e) {
        print('💥 OTP verification error: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'An error occurred during verification. Please try again.',
                style: GoogleFonts.plusJakartaSans(fontSize: 14),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      }
    }
  }

  void _handleResendOTP() async {
    try {
      final success = await context.read<AuthProvider>().requestOTP(
        _emailController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'OTP resent successfully!',
              style: GoogleFonts.plusJakartaSans(fontSize: 14),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      print('💥 Resend OTP error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to resend OTP. Please try again.',
              style: GoogleFonts.plusJakartaSans(fontSize: 14),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

  String? _validateEmailOrMuid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or MUID is required';
    }
    return null;
  }

  String? _validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'OTP must contain only numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedImage(imagePath: 'assets/images/alien.jpg'),

                // µLearn Logo
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.network(
                    "https://app.mulearn.org/assets/%C2%B5Learn-qsNKBi56.png",
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 10),

                // Title
                Text(
                  "Hello ! Welcome back",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Dynamic Subtitle based on OTP state
                Text(
                  _otpSent
                      ? "Enter the 6-digit OTP sent to your email/phone"
                      : "Enter your muid or email address to request for OTP",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Email / Muid Field (Enhanced with validation)
                TextFormField(
                  controller: _emailController,
                  enabled: !_otpSent, // Disable when OTP is sent
                  validator: _validateEmailOrMuid,
                  decoration: InputDecoration(
                    hintText: "Email or Muid",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                    filled: true,
                    fillColor:
                        _otpSent ? Colors.grey[100] : const Color(0xFFF5F5F5),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    errorStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: Colors.red[700],
                    ),
                  ),
                ),

                // OTP Field (Shows when OTP is sent)
                if (_otpSent) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: _validateOTP,
                    decoration: InputDecoration(
                      hintText: "Enter 6-digit OTP",
                      hintStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      counterText: "", // Hide character counter
                      errorStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Forgot Password + Login with Password (Hide when OTP sent)
                if (!_otpSent) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot your Password",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Login with Password",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 24),

                // Dynamic Button (Request OTP / Verify OTP)
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF456FF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:
                            authProvider.state == AuthState.loading
                                ? null
                                : (_otpSent
                                    ? _handleVerifyOTP
                                    : _handleRequestOTP),
                        child:
                            authProvider.state == AuthState.loading
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  _otpSent ? "Verify OTP" : "Request OTP",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    );
                  },
                ),

                // Resend OTP and Change Email options (Show when OTP sent)
                if (_otpSent) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _handleResendOTP,
                        child: Text(
                          "Resend OTP",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: const Color(0xFF456FF6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        " • ",
                        style: GoogleFonts.plusJakartaSans(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _otpSent = false;
                            _otpController.clear();
                          });
                        },
                        child: Text(
                          "Change Email",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // Error message display
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.state == AuthState.error &&
                        authProvider.errorMessage != null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  authProvider.errorMessage!,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.red[700],
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 24),

                // Don't have account? Sign up (Hide when OTP sent)
                if (!_otpSent) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF456FF6),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Homepage Link
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to Homepage
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Text(
                      "Homepage",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ] else ...[
                  // Back to login link when OTP sent
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Back to Login",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper extension for additional utilities
extension LoginWithOtPageExtensions on _LoginWithOtPageState {
  void _clearForm() {
    _emailController.clear();
    _otpController.clear();
    setState(() {
      _otpSent = false;
    });
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message, style: GoogleFonts.plusJakartaSans()),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

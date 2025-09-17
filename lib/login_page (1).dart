// Complete fixed login_page.dart - Keeps your exact UI, fixes authentication
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mu/forgot_password.dart';
import 'package:mu/login_with_otp%20(1).dart';
import 'package:mu/signup_page.dart';
import 'package:mu/widgets/animate.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    // Check if form is valid
    if (_formKey.currentState!.validate()) {
      try {
        // Call your existing AuthProvider.login method with the parameters it expects
        await context.read<AuthProvider>().login(
          emailController.text.trim(), // emailOrMuid parameter
          passwordController.text, // password parameter
        );

        // Check if widget is still mounted before using context
        if (!mounted) return;

        // The AuthInitializer will automatically handle navigation to HomeScreen
        // No manual navigation needed - your existing setup will handle it
      } catch (e) {
        // Handle any unexpected errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'An error occurred. Please try again.',
                style: GoogleFonts.plusJakartaSans(),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        // Local images for the header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 300,
                              child: AnimatedImage(
                                imagePath: 'assets/images/alien.jpg',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // µLearn logo
                        Image.network(
                          "https://app.mulearn.org/assets/%C2%B5Learn-qsNKBi56.png",
                          height: 40,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 30),

                        // Title and Subtitle
                        Text(
                          "Hello ! Welcome back",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign in to your account",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Email or Muid field
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email or MUID is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email or Muid",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: Colors.red[700],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Password field
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: Colors.red[700],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Forgot Password and Login with OTP links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot your Password",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const LoginWithOtPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login with OTP",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Sign in button with proper state management
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                onPressed:
                                    authProvider.state == AuthState.loading
                                        ? null
                                        : _handleLogin,
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
                                          "Sign in",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                            );
                          },
                        ),

                        // Error message with proper lifecycle check
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
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      // Clear error button
                                      IconButton(
                                        onPressed: () {
                                          authProvider.clearError();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red[700],
                                          size: 16,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),

                        const SizedBox(height: 20),

                        // Don't have an account link
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: const Text("Don't have an account? Sign up"),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Keep your SafeAsyncStateMixin exactly as it is
mixin SafeAsyncStateMixin<T extends StatefulWidget> on State<T> {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  void safeNavigate(BuildContext context, Widget page) {
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    }
  }

  void safeNavigateReplacement(BuildContext context, String routeName) {
    if (mounted) {
      Navigator.pushReplacementNamed(context, routeName);
    }
  }

  void safeShowSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: GoogleFonts.plusJakartaSans()),
          backgroundColor: isError ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }
}

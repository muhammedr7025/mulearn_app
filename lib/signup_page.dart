// Enhanced signup_page.dart - Preserving your exact design with API integration
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mu/widgets/animate.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool agreedToTerms = false;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    // Validate form and terms agreement
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please agree to the Terms & Conditions',
            style: GoogleFonts.plusJakartaSans(),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Split full name into first and last name
    final nameParts = nameController.text.trim().split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    await context.read<AuthProvider>().createAccount(
      email: emailController.text.trim(),
      password: passwordController.text,
      firstName: firstName,
      lastName:
          lastName.isEmpty
              ? firstName
              : lastName, // Use firstName as lastName if no last name provided
    );

    // Navigate to home if signup successful
    if (mounted && context.read<AuthProvider>().isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedImage(imagePath: 'assets/images/alien.jpg'),
                const SizedBox(height: 20),

                // µLearn logo
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.network(
                    "https://app.mulearn.org/assets/%C2%B5Learn-qsNKBi56.png",
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Create an Account",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Please Enter Your Information",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 30),

                // Email field with validation
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  decoration: InputDecoration(
                    hintText: "Email id *",
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
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
                const SizedBox(height: 18),

                // Full Name field with validation
                TextFormField(
                  controller: nameController,
                  validator: _validateName,
                  decoration: InputDecoration(
                    hintText: "Full Name *",
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
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
                const SizedBox(height: 18),

                // Password field with validation
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                    hintText: "Password *",
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Terms and conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: agreedToTerms,
                      onChanged: (val) {
                        setState(() {
                          agreedToTerms = val ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "I agree to the ",
                          style: GoogleFonts.plusJakartaSans(fontSize: 13),
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  "\nBy checking this box, you also confirm that you are 13 years old or older.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Support Group
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.headset_mic,
                      size: 18,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 6),
                    Text.rich(
                      TextSpan(
                        text: "Facing Issues? ",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text: "Join our Support Group!",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Register button with state management
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:
                            authProvider.state == AuthState.loading
                                ? null
                                : _handleRegister,
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
                                  "Register",
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

                const SizedBox(height: 20),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // go back to login page
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Additional utility for handling success feedback
extension SignUpPageExtensions on _SignUpPageState {
  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Account created successfully!',
              style: GoogleFonts.plusJakartaSans(),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

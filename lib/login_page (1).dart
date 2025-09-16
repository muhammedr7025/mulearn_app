import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mu/forgot_password.dart';
import 'package:mu/login_with_otp%20(1).dart';
import 'package:mu/signup_page.dart';
import 'package:mu/widgets/animate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Prevent overflow when keyboard opens
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // Local images for the header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100, // small height
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
                        "Enter your muid or email address to request for OTP",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email or Muid field
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email or Muid",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Password field
                      TextField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                  builder: (context) => const LoginWithOtPage(),
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

                      // Sign in button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign in",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
            );
          },
        ),
      ),
    );
  }
}

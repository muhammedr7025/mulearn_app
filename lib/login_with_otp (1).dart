import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mu/forgot_password.dart';
import 'package:mu/login_page%20(1).dart';
import 'package:mu/signup_page.dart';
import 'package:mu/widgets/animate.dart';

class LoginWithOtPage extends StatelessWidget {
  const LoginWithOtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // <-- The scaffold background is now white
      body: SafeArea(
        
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
 AnimatedImage(
                  imagePath: 'assets/images/alien.jpg', // <--- Use your local GIF path here
                ),
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

              // Subtitle
              Text(
                "Enter your muid or email address to request for OTP",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Email / Muid Field
              TextField(
                decoration: InputDecoration(
                  hintText: "Email or Muid",
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
                ),
              ),

              const SizedBox(height: 16),

              // Forgot Password + Login with Password
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
                                  builder: (context) => const LoginPage(),
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

              const SizedBox(height: 24),

              // Request OTP Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF456FF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginWithOtPage(),
                                ),
                              );
                  },
                  child: Text(
                    "Request OTP",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Don't have account? Sign up
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
            ],
          ),
        ),
      ),
    );
  }
}
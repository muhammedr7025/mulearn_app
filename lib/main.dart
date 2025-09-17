import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mu/profpag.dart';
import 'package:provider/provider.dart';
import 'package:mu/login_page%20(1).dart';
import 'package:mu/signup_page.dart';
import 'package:mu/forgot_password.dart';
import 'package:mu/login_with_otp%20(1).dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'µLearn',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'PlusJakartaSans',
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthInitializer(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/login-otp': (context) => const LoginWithOtPage(),
          '/forgot-password': (context) => const ForgotPasswordPage(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfilePage(), // Add this line
        },
      ),
    );
  }
}

// Auth Initializer - Determines initial route based on auth state
class AuthInitializer extends StatefulWidget {
  const AuthInitializer({Key? key}) : super(key: key);

  @override
  State<AuthInitializer> createState() => _AuthInitializerState();
}

class _AuthInitializerState extends State<AuthInitializer> {
  @override
  void initState() {
    super.initState();
    // Initialize auth state when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().initAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        switch (authProvider.state) {
          case AuthState.initial:
          case AuthState.loading:
            return const LoadingScreen();
          case AuthState.authenticated:
            return const HomeScreen(); // Replace with your main app screen
          case AuthState.unauthenticated:
          case AuthState.error:
            return LoginPage();
        }
      },
    );
  }
}

// Loading Screen
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://app.mulearn.org/assets/%C2%B5Learn-qsNKBi56.png",
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Loading...',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Home Screen - Replace with your main app content
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'µLearn Dashboard',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message
                Text(
                  'Welcome back!',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                if (user != null) ...[
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    user.email,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),

                  if (user.muid != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'MUID: ${user.muid}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],

                const SizedBox(height: 32),

                // Success message
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green[600],
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Authentication Successful!',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your authentication system is now fully integrated and working.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Logout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthProvider>().logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Logout',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: GoogleFonts.plusJakartaSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.plusJakartaSans(color: Colors.grey[600]),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthProvider>().logout();
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

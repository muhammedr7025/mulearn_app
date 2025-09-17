import 'package:flutter/foundation.dart';
import 'package:mu/models/auth_models.dart';
import 'package:mu/services/auth_service.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.initial;
  AuthUser? _user;
  String? _errorMessage;

  AuthState get state => _state;
  AuthUser? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _state == AuthState.authenticated;

  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(AuthState.error);
  }

  // Initialize auth state
  Future<void> initAuth() async {
    _setState(AuthState.loading);
    final isLoggedIn = await AuthService.isLoggedIn();
    if (isLoggedIn) {
      _setState(AuthState.authenticated);
    } else {
      _setState(AuthState.unauthenticated);
    }
  }

  // Login with password
  Future<void> login(String emailOrMuid, String password) async {
    _setState(AuthState.loading);

    final response = await AuthService.login(
      LoginRequest(emailOrMuid: emailOrMuid, password: password),
    );

    if (response.success && response.data != null) {
      _user = response.data;
      _setState(AuthState.authenticated);
    } else {
      _setError(response.message);
    }
  }

  // Create account
  Future<void> createAccount({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? muid,
  }) async {
    _setState(AuthState.loading);

    final response = await AuthService.createAccount(
      CreateAccountRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        muid: muid,
      ),
    );

    if (response.success && response.data != null) {
      _user = response.data;
      _setState(AuthState.authenticated);
    } else {
      _setError(response.message);
    }
  }

  // Request OTP
  Future<bool> requestOTP(String emailOrMuid) async {
    _setState(AuthState.loading);

    final response = await AuthService.requestOTP(
      OTPRequest(emailOrMuid: emailOrMuid),
    );

    if (response.success) {
      _setState(AuthState.unauthenticated);
      return true;
    } else {
      _setError(response.message);
      return false;
    }
  }

  // Verify OTP and login
  Future<void> verifyOTPLogin(String emailOrMuid, String otp) async {
    _setState(AuthState.loading);

    final response = await AuthService.verifyOTPLogin(
      OTPVerifyRequest(emailOrMuid: emailOrMuid, otp: otp),
    );

    if (response.success && response.data != null) {
      _user = response.data;
      _setState(AuthState.authenticated);
    } else {
      _setError(response.message);
    }
  }

  // Forgot password
  Future<bool> forgotPassword(String email) async {
    _setState(AuthState.loading);

    final response = await AuthService.forgotPassword(
      ForgotPasswordRequest(email: email),
    );

    if (response.success) {
      _setState(AuthState.unauthenticated);
      return true;
    } else {
      _setError(response.message);
      return false;
    }
  }

  // Reset password
  Future<bool> resetPassword(String token, String newPassword) async {
    _setState(AuthState.loading);

    final response = await AuthService.resetPassword(
      ResetPasswordRequest(token: token, newPassword: newPassword),
    );

    if (response.success) {
      _setState(AuthState.unauthenticated);
      return true;
    } else {
      _setError(response.message);
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await AuthService.logout();
    _user = null;
    _setState(AuthState.unauthenticated);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mu/models/auth_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Configure which API version to use
  static const bool useV1Api = true; // Set to true to use V1, false for V2

  static const String baseUrlV1 = 'https://mulearn.org/api/v1';
  static const String baseUrlV2 = 'https://api.mulearn.org/api/v2';
  static const String tokenKey = 'auth_token';

  static String? _token;

  // Get the appropriate base URL
  static String get baseUrl => useV1Api ? baseUrlV1 : baseUrlV2;

  // Get stored token
  static Future<String?> getToken() async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(tokenKey);
    return _token;
  }

  // Save token
  static Future<void> saveToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  // Remove token
  static Future<void> removeToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  // Get headers with auth
  static Future<Map<String, String>> _getHeaders({
    bool includeAuth = true,
  }) async {
    final token = includeAuth ? await getToken() : null;
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Login with password - supports both V1 and V2
  static Future<ApiResponse<AuthUser>> login(LoginRequest request) async {
    try {
      final String endpoint;
      if (useV1Api) {
        endpoint = '$baseUrlV1/auth/user-authentication/';
      } else {
        endpoint = '$baseUrlV2/dashboard/user/login';
      }

      print('🔐 Attempting login to: $endpoint');
      print('📧 Email/MUID: ${request.emailOrMuid}');

      final response = await http.post(
        Uri.parse(endpoint),
        headers: await _getHeaders(
          includeAuth: false,
        ), // Don't include auth token for login
        body: jsonEncode(request.toJson()),
      );

      print('📱 Response Status: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      // Handle empty response body (like with 301 redirects)
      if (response.body.isEmpty) {
        print('❌ Empty response body - likely a redirect or server error');
        return ApiResponse(
          success: false,
          message:
              'Server returned empty response (Status: ${response.statusCode}). This might be a redirect or server configuration issue.',
        );
      }

      // Handle non-JSON responses
      late Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        print('❌ Failed to parse JSON response: $e');
        return ApiResponse(
          success: false,
          message:
              'Invalid response format from server. Response: ${response.body}',
        );
      }

      // Handle the actual MuLearn API response format
      if (response.statusCode == 200) {
        final hasError = data['hasError'] as bool? ?? true;
        final responseData = data['response'] as Map<String, dynamic>?;

        if (!hasError && responseData != null) {
          // Extract user info and token from the response
          final accessToken = responseData['accessToken'] as String?;
          final refreshToken = responseData['refreshToken'] as String?;

          if (accessToken != null) {
            await saveToken(accessToken);
            print('✅ Login successful, token saved');

            // Create a user object - you might need to get user details separately
            // For now, create a minimal user object
            final user = AuthUser(
              id: 'unknown', // You might need to decode the JWT or call another endpoint
              email:
                  request.emailOrMuid.contains('@')
                      ? request.emailOrMuid
                      : 'unknown',
              firstName: 'Unknown',
              lastName: 'User',
              muid:
                  request.emailOrMuid.contains('@')
                      ? null
                      : request.emailOrMuid,
              token: accessToken,
            );

            return ApiResponse(
              success: true,
              message: 'Login successful',
              data: user,
            );
          }
        }

        // Handle error case
        final messageObj = data['message'] as Map<String, dynamic>?;
        final generalMessages = messageObj?['general'] as List?;
        final errorMessage =
            generalMessages?.isNotEmpty == true
                ? generalMessages!.first.toString()
                : 'Login failed';

        print('❌ Login failed: $errorMessage');
        return ApiResponse(success: false, message: errorMessage);
      } else {
        print('❌ Login failed with status: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Login failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      print('💥 Network error: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Test both API versions to see which works
  static Future<Map<String, dynamic>> testBothApiVersions(
    LoginRequest request,
  ) async {
    final results = <String, dynamic>{};

    print('🧪 Testing both API versions...\n');

    // Test V1
    try {
      print('--- Testing V1 API ---');
      final v1Response = await http.post(
        Uri.parse('$baseUrlV1/auth/user-authentication/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      print('V1 Status: ${v1Response.statusCode}');
      print('V1 Body: ${v1Response.body}');

      if (v1Response.body.isNotEmpty) {
        final v1Data = jsonDecode(v1Response.body);
        results['v1'] = {
          'statusCode': v1Response.statusCode,
          'hasError': v1Data['hasError'] ?? true,
          'message': v1Data['message']?.toString() ?? 'No message',
          'hasToken': v1Data['response']?['accessToken'] != null,
        };
      } else {
        results['v1'] = {'statusCode': v1Response.statusCode, 'body': 'empty'};
      }
    } catch (e) {
      print('V1 Error: $e');
      results['v1'] = {'error': e.toString()};
    }

    print('\n--- Testing V2 API ---');
    // Test V2
    try {
      final v2Response = await http.post(
        Uri.parse('$baseUrlV2/dashboard/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      print('V2 Status: ${v2Response.statusCode}');
      print('V2 Body: ${v2Response.body}');

      final v2Data = jsonDecode(v2Response.body);
      results['v2'] = {
        'statusCode': v2Response.statusCode,
        'success': v2Data['success'] ?? false,
        'message': v2Data['message'] ?? 'No message',
        'hasToken': v2Data['data']?['token'] != null,
      };
    } catch (e) {
      print('V2 Error: $e');
      results['v2'] = {'error': e.toString()};
    }

    print('\n🎯 Test Results:');
    print('V1 API: ${results['v1']}');
    print('V2 API: ${results['v2']}');

    return results;
  }

  // Create new account
  static Future<ApiResponse<AuthUser>> createAccount(
    CreateAccountRequest request,
  ) async {
    try {
      final String endpoint;
      if (useV1Api) {
        // You'll need to find the correct V1 registration endpoint
        endpoint = '$baseUrlV1/register/user-register/'; // Adjust as needed
      } else {
        endpoint = '$baseUrlV2/dashboard/user/register';
      }

      final response = await http.post(
        Uri.parse(endpoint),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode(request.toJson()),
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data['success']) {
        final user = AuthUser.fromJson(data['data']);
        if (user.token != null) {
          await saveToken(user.token!);
        }
        return ApiResponse.fromJson(data, user);
      } else {
        return ApiResponse.fromJson(data, null);
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Request OTP
  static Future<ApiResponse<void>> requestOTP(OTPRequest request) async {
    try {
      final String endpoint;
      if (useV1Api) {
        endpoint = '$baseUrlV1/auth/request-otp/'; // Match your curl endpoint
      } else {
        endpoint = '$baseUrlV2/dashboard/user/otp/request';
      }

      print('📱 Requesting OTP to: $endpoint');
      print('📧 Email/MUID: ${request.emailOrMuid}');

      final response = await http.post(
        Uri.parse(endpoint),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode(request.toJson()),
      );

      print('📱 Response Status: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      // Handle empty response body
      if (response.body.isEmpty) {
        print('❌ Empty response body');
        return ApiResponse(
          success: false,
          message: 'Server returned empty response',
        );
      }

      // Handle non-JSON responses
      late Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        print('❌ Failed to parse JSON response: $e');
        return ApiResponse(
          success: false,
          message: 'Invalid response format from server',
        );
      }

      // Handle MuLearn API response format for OTP request
      if (response.statusCode == 200) {
        final hasError = data['hasError'] as bool? ?? true;

        if (!hasError) {
          print('✅ OTP request successful');
          return ApiResponse(success: true, message: 'OTP sent successfully');
        } else {
          final messageObj = data['message'] as Map<String, dynamic>?;
          final generalMessages = messageObj?['general'] as List?;
          final errorMessage =
              generalMessages?.isNotEmpty == true
                  ? generalMessages!.first.toString()
                  : 'Failed to send OTP';

          print('❌ OTP request failed: $errorMessage');
          return ApiResponse(success: false, message: errorMessage);
        }
      } else {
        print('❌ OTP request failed with status: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed to send OTP (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      print('💥 OTP request error: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Verify OTP and login - Fixed to match expected format
  static Future<ApiResponse<AuthUser>> verifyOTPLogin(
    OTPVerifyRequest request,
  ) async {
    try {
      final String endpoint;
      if (useV1Api) {
        endpoint =
            '$baseUrlV1/auth/verify-otp/'; // Likely endpoint for OTP verification
      } else {
        endpoint = '$baseUrlV2/dashboard/user/otp/verify';
      }

      print('🔐 Verifying OTP to: $endpoint');
      print('📧 Email/MUID: ${request.emailOrMuid}');
      print('🔢 OTP: ${request.otp}');

      final response = await http.post(
        Uri.parse(endpoint),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode(request.toJson()),
      );

      print('📱 Response Status: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      // Handle empty response body
      if (response.body.isEmpty) {
        print('❌ Empty response body');
        return ApiResponse(
          success: false,
          message: 'Server returned empty response',
        );
      }

      // Handle non-JSON responses
      late Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        print('❌ Failed to parse JSON response: $e');
        return ApiResponse(
          success: false,
          message: 'Invalid response format from server',
        );
      }

      // Handle MuLearn API response format for OTP verification
      if (response.statusCode == 200) {
        final hasError = data['hasError'] as bool? ?? true;
        final responseData = data['response'] as Map<String, dynamic>?;

        if (!hasError && responseData != null) {
          // Extract user info and token from the response
          final accessToken = responseData['accessToken'] as String?;

          if (accessToken != null) {
            await saveToken(accessToken);
            print('✅ OTP verification successful, token saved');

            // Create a user object
            final user = AuthUser(
              id: responseData['id']?.toString() ?? 'unknown',
              email:
                  request.emailOrMuid.contains('@')
                      ? request.emailOrMuid
                      : responseData['email']?.toString() ?? 'unknown',
              firstName: responseData['firstName']?.toString() ?? 'Unknown',
              lastName: responseData['lastName']?.toString() ?? 'User',
              muid:
                  request.emailOrMuid.contains('@')
                      ? responseData['muid']?.toString()
                      : request.emailOrMuid,
              token: accessToken,
            );

            return ApiResponse(
              success: true,
              message: 'OTP verification successful',
              data: user,
            );
          }
        }

        // Handle error case
        final messageObj = data['message'] as Map<String, dynamic>?;
        final generalMessages = messageObj?['general'] as List?;
        final errorMessage =
            generalMessages?.isNotEmpty == true
                ? generalMessages!.first.toString()
                : 'OTP verification failed';

        print('❌ OTP verification failed: $errorMessage');
        return ApiResponse(success: false, message: errorMessage);
      } else {
        print('❌ OTP verification failed with status: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'OTP verification failed (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      print('💥 OTP verification error: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Verify reset password token
  static Future<ApiResponse<void>> verifyResetToken(String token) async {
    try {
      final endpoint =
          '$baseUrl/dashboard/user/reset-password/verify-token/$token';

      final response = await http.get(
        Uri.parse(endpoint),
        headers: await _getHeaders(),
      );

      final data = jsonDecode(response.body);
      return ApiResponse.fromJson(data, null);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Reset password
  static Future<ApiResponse<void>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final endpoint =
          '$baseUrl/dashboard/user/reset-password/${request.token}';

      final response = await http.post(
        Uri.parse(endpoint),
        headers: await _getHeaders(),
        body: jsonEncode({'newPassword': request.newPassword}),
      );

      final data = jsonDecode(response.body);
      return ApiResponse.fromJson(data, null);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Logout
  static Future<void> logout() async {
    await removeToken();
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  // Get current user info (if authenticated)
  static Future<ApiResponse<AuthUser>> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) {
        return ApiResponse(
          success: false,
          message: 'No authentication token found',
        );
      }

      final endpoint = '$baseUrl/dashboard/user/info';

      final response = await http.get(
        Uri.parse(endpoint),
        headers: await _getHeaders(),
      );

      print('👤 Getting user info from: $endpoint');
      print('📱 Response Status: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      if (response.body.isEmpty) {
        return ApiResponse(
          success: false,
          message: 'Empty response from server',
        );
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final hasError = data['hasError'] as bool? ?? true;
        final responseData = data['response'] as Map<String, dynamic>?;

        if (!hasError && responseData != null) {
          // Adapt the response to your AuthUser model
          final user = AuthUser(
            id: responseData['id']?.toString() ?? 'unknown',
            email: responseData['email']?.toString() ?? 'unknown',
            firstName:
                responseData['firstName']?.toString() ??
                responseData['first_name']?.toString() ??
                'Unknown',
            lastName:
                responseData['lastName']?.toString() ??
                responseData['last_name']?.toString() ??
                'User',
            muid: responseData['muid']?.toString(),
            token: token, // Use the stored token
          );

          return ApiResponse(
            success: true,
            message: 'User info retrieved successfully',
            data: user,
          );
        }
      }

      return ApiResponse(
        success: false,
        message: 'Failed to get user information',
      );
    } catch (e) {
      print('💥 Error getting user info: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Enhanced login that also gets user details
  static Future<ApiResponse<AuthUser>> loginWithUserDetails(
    LoginRequest request,
  ) async {
    // First, perform login
    final loginResult = await login(request);

    if (!loginResult.success) {
      return loginResult;
    }

    // Then get user details
    final userResult = await getCurrentUser();

    if (userResult.success && userResult.data != null) {
      return userResult;
    } else {
      // Login succeeded but couldn't get user details - return basic info
      return loginResult;
    }
  }

  static forgotPassword(ForgotPasswordRequest forgotPasswordRequest) {}
  
}

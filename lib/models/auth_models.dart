class LoginRequest {
  final String emailOrMuid;
  final String password;

  LoginRequest({required this.emailOrMuid, required this.password});

  Map<String, dynamic> toJson() => {
    'emailOrMuid': emailOrMuid,
    'password': password,
  };
}

class CreateAccountRequest {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? muid;

  CreateAccountRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.muid,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    if (muid != null) 'muid': muid,
  };
}

class OTPRequest {
  final String emailOrMuid;

  OTPRequest({required this.emailOrMuid});

  Map<String, dynamic> toJson() => {'emailOrMuid': emailOrMuid};
}

class OTPVerifyRequest {
  final String emailOrMuid;
  final String otp;

  OTPVerifyRequest({required this.emailOrMuid, required this.otp});

  Map<String, dynamic> toJson() => {'emailOrMuid': emailOrMuid, 'otp': otp};
}

class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class ResetPasswordRequest {
  final String token;
  final String newPassword;

  ResetPasswordRequest({required this.token, required this.newPassword});

  Map<String, dynamic> toJson() => {'token': token, 'newPassword': newPassword};
}

class AuthUser {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? muid;
  final String? token;

  AuthUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.muid,
    this.token,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    muid: json['muid'],
    token: json['token'],
  );
}

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final Map<String, dynamic>? errors;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T? data) =>
      ApiResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: data,
        errors: json['errors'],
      );
}

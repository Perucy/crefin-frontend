import 'user_model.dart';

class LoginResponse {
  final bool success;
  final User user;
  final String token;
  final String refreshToken;
  final String message;

  LoginResponse({
    required this.success,
    required this.user,
    required this.token,
    required this.refreshToken,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      user: User.fromJson(json['data']['user']),
      token: json['data']['token'],
      refreshToken: json['data']['refreshToken'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': {
        'user': user.toJson(),
        'token': token,
        'refreshToken': refreshToken,
      },
      'message': message,
    };
  }

}
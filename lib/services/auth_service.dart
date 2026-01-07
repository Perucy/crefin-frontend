import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/login_response.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class AuthService {
  // apiclient instance
  final ApiClient _apiClient;

  // Secure storage instance
  final _secureStorage = const FlutterSecureStorage();

  // keys for secure storage
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';

  AuthService(this._apiClient);

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      // make request
      final response = await _apiClient.dio.post(
        ApiConfig.login,
        data: {'email': email, 'password': password},
      );

      // parse response
      final loginResponse = LoginResponse.fromJson(response.data);

      // save tokens
      await _secureStorage.write(key: _accessTokenKey, value: loginResponse.token);
      await _secureStorage.write(key: _refreshTokenKey, value: loginResponse.refreshToken);
      await _secureStorage.write(key: _userIdKey, value: loginResponse.user.id);

      return loginResponse.user;

    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      // make request
      final response = await _apiClient.dio.post(
        ApiConfig.register,
        data: {'name': name, 'email': email, 'password': password, if (phone != null) 'phone': phone},
      );

      // parse response
      final registerResponse = LoginResponse.fromJson(response.data);

      // save tokens
      await _secureStorage.write(key: _accessTokenKey, value: registerResponse.token);
      await _secureStorage.write(key: _refreshTokenKey, value: registerResponse.refreshToken);
      await _secureStorage.write(key: _userIdKey, value: registerResponse.user.id);

      return registerResponse.user;

    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Registration failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<void> logout() async {
    await _secureStorage.deleteAll();

    try {
      await _apiClient.dio.post(ApiConfig.logout);
    } catch (e) {
      // Ignore errors - logging out
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }
}
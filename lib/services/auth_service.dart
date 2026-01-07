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
  final _secureStorage = FlutterSecureStorage();

  // keys for secure storage
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';

  AuthService(this._apiClient);

  Future<User> login({
    required String email,
    required String password,
  }) async {
    // todo:
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    // todo:
  }

  Future<void> logout() async {
    // todo:
  }

  Future<bool> isLoggedIn() async {
    // todo
  }

  Future<String?> getToken() async {
    // todo
  }

  Future<String?> getRefreshToken() async {
    // todo
  }


}
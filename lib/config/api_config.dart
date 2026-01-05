class ApiConfig {
  static const String baseUrl = 'http://localhost:3000/api/v1';

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  
  static const String income = '/income';
  static const String expenses = '/expenses';
  static const String invoices = '/invoices';
  static const String clients = '/clients';
  static const String dashboard = '/dashboard';
  static const String goals = '/goals';
}
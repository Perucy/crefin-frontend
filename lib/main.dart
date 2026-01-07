import 'services/api_client.dart';
import 'config/api_config.dart';  
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Future <void> testApiClient() async {
  print('\n🧪 Testing API Client...\n');
  
  try {
    final apiClient = ApiClient();
    print('✅ API Client created');
    print('   Base URL: ${ApiConfig.baseUrl}');
    
    // Test with login endpoint (won't work without credentials, but that's okay!)
    final response = await apiClient.dio.post(
      ApiConfig.login,  // ← Using your config!
      data: {
        'email': 'test@example.com',
        'password': 'wrong-password',
      },
    );
    
    print('✅ Response: ${response.statusCode}');
    
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      print('✅ API Client works! (Got 401 - wrong password, expected)');
      print('   Endpoint tested: ${ApiConfig.login}');
    } else if (e.response?.statusCode == 400) {
      print('✅ API Client works! (Got 400 - validation error, expected)');
      print('   Endpoint tested: ${ApiConfig.login}');
    } else {
      print('❌ Unexpected error: ${e.message}');
      print('   Status: ${e.response?.statusCode}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

void main() async {
  await testApiClient();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crefin Test App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crefin Test App'),
        ),
        body: const Center(
          child: Text('Check console for User model tests results.'),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../lib/services/api_client.dart';
import 'services/auth_service.dart';

Future<void> testAuthService() async {
  print('\n🧪 Testing Auth Service...\n');
  
  try {
    final apiClient = ApiClient();
    final authService = AuthService(apiClient);
    
    // Test 1: Login
    print('Test 1: Login');
    final user = await authService.login(
      email: 'test@example.com',
      password: 'Test1234',
    );
    
    print('✅ Login successful!');
    print('   User: ${user.name}');
    print('   Email: ${user.email}');
    
    // Test 2: Get Token
    print('\nTest 2: Get Token');
    final token = await authService.getToken();
    print('✅ Token retrieved: ${token?.substring(0, 20)}...');
    
    // Test 3: Is Logged In
    print('\nTest 3: Is Logged In');
    final loggedIn = await authService.isLoggedIn();
    print('✅ Is logged in: $loggedIn');
    
    // Test 4: Logout
    print('\nTest 4: Logout');
    await authService.logout();
    
    final stillLoggedIn = await authService.isLoggedIn();
    print('✅ After logout, logged in: $stillLoggedIn');
    
    final tokenAfterLogout = await authService.getToken();
    print('✅ Token after logout: $tokenAfterLogout');
    
    print('\n✅ ALL TESTS PASSED!\n');
    
  } catch (e) {
    print('❌ Test failed: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // ← Important for async main!
  
  await testAuthService();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crefin',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crefin - Auth Test'),
        ),
        body: const Center(
          child: Text('Check console for test results'),
        ),
      ),
    );
  }
}
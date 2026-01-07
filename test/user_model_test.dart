import 'package:flutter/material.dart';
import '../models/user_model.dart';  // ← Import your User model

void main() {
  testUserModel();  // ← Test first
  runApp(const MyApp());
}

void testUserModel() {
  print('\n🧪 Testing User Model...\n');
  
  // Test 1: With phone
  Map<String, dynamic> json1 = {
    'id': '123',
    'email': 'test@example.com',
    'name': 'Test User',
    'phone': '+1234567890',
    'profilePicture': null,
    'profession': null,
    'skills': [],
    'hourlyRate': null,
    'isPremium': false,
    'isEmailVerified': false,
    'premiumExpiry': null,
    'emailVerificationExpires': '2025-10-23T01:48:24.813Z',
    'passwordResetExpires': null,
    'lastLoginAt': '2026-01-02T20:26:33.654Z',
    'createdAt': '2025-10-22T01:48:24.817Z',
    'updatedAt': '2026-01-02T20:26:33.658Z',
  };
  
  // Test 2: Without phone (null)
  Map<String, dynamic> json2 = {
    'id': '456',
    'email': 'test2@example.com',
    'name': 'Test User 2',
    'phone': null,  // ← null phone
    'profilePicture': null,
    'profession': null,
    'skills': ['Flutter', 'Dart'],
    'hourlyRate': 75.50,
    'isPremium': true,
    'isEmailVerified': true,
    'premiumExpiry': '2025-12-31T23:59:59.000Z',
    'emailVerificationExpires': null,
    'passwordResetExpires': null,
    'lastLoginAt': null,
    'createdAt': '2025-10-22T01:48:24.817Z',
    'updatedAt': '2026-01-02T20:26:33.658Z',
  };
  
  try {
    // Test fromJson with phone
    User user1 = User.fromJson(json1);
    print('✅ Test 1 passed: ${user1.name}');
    print('   Phone: ${user1.phone}');
    print('   Email: ${user1.email}');
    
    // Test fromJson without phone
    User user2 = User.fromJson(json2);
    print('✅ Test 2 passed: ${user2.name}');
    print('   Phone: ${user2.phone ?? "No phone"}');
    print('   Skills: ${user2.skills}');
    print('   Hourly Rate: \$${user2.hourlyRate}');
    
    // Test toJson
    Map<String, dynamic> backToJson = user1.toJson();
    print('✅ Test 3 passed: toJson works');
    print('   Email in JSON: ${backToJson['email']}');
    print('   Created in JSON: ${backToJson['createdAt']}');
    
    print('\n✅ All tests passed!\n');
    
  } catch (e, stackTrace) {
    print('❌ Error: $e');
    print('Stack trace: $stackTrace');
  }
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
import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../utils/app_storage.dart';
import '../services/auth_service.dart';
import '../services/api_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Show logo for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final apiClient = ApiClient();
    final authService = AuthService(apiClient);

    // Check authentication and onboarding status
    final isLoggedIn = await authService.isLoggedIn();
    final hasSeenOnboarding = await AppStorage.hasSeenOnboarding();

    if (!mounted) return;

    // Navigate based on status
    if (isLoggedIn) {
      // User is logged in → Go to MainScreen
      Navigator.pushReplacementNamed(context, '/main');
    } else if (!hasSeenOnboarding) {
      // First time user → Show onboarding
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else {
      // Returning user (not logged in) → Go to Login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo with fade-in effect
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.8 + (value * 0.2),
                    child: child,
                  ),
                );
              },
              child: const Logo(size: LogoSize.large),
            ),
            
            const SizedBox(height: 24),
            
            // App name with fade-in
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeIn,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: const Text(
                'Crefin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Tagline
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Text(
                'Smart Finance for Freelancers',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../services/auth_storage.dart';
import 'onboard_1.dart';  // ← Changed
import 'onboard_2.dart';  // ← Changed
import 'onboard_3.dart';  // ← Changed

class OnboardingContainer extends StatefulWidget {
  const OnboardingContainer({super.key});

  @override
  State<OnboardingContainer> createState() => _OnboardingContainerState();
}

class _OnboardingContainerState extends State<OnboardingContainer> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _skipOrFinish() async {
    // Mark onboarding as completed
    await AuthStorage.completeOnboarding();
    
    if (!mounted) return;
    
    // Navigate to login
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      children: [
        OnboardingSlide1(
          onNext: _nextPage,
          onSkip: _skipOrFinish,
        ),
        OnboardingSlide2(
          onNext: _nextPage,
          onSkip: _skipOrFinish,
        ),
        OnboardingSlide3(
          onGetStarted: _skipOrFinish,
          onSkip: _skipOrFinish,
        ),
      ],
    );
  }
}
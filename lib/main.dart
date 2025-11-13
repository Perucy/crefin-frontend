import 'package:flutter/material.dart';
import 'dart:ui';
import 'colors.dart';
import 'settings.dart';
import 'income.dart';
import 'dashboard.dart';

void main() {
  runApp(const CrefinApp());
}

class CrefinApp extends StatefulWidget {
  const CrefinApp({super.key});

  @override
  State<CrefinApp> createState() => _CrefinAppState();
}

class _CrefinAppState extends State<CrefinApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //light theme
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        cardColor: AppColors.lightCard,
      ),

      //dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        cardColor: AppColors.darkCard,
      ),

      themeMode: _themeMode,

      home: MainScreen(onToggleTheme: _toggleTheme),
    );
  }
}

class MainScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  
  const MainScreen({super.key, required this.onToggleTheme});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<String> _screens = [
    'Dashboard',
    'Income',
    'Finances',
    'AI',
    'Settings'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getScreenForIndex(_currentIndex),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildDynamicIslandNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const IncomeScreen();
      case 4:
        return SettingsScreen(onToggleTheme: widget.onToggleTheme);  // Pass callback
      default:
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Center(
              child: Text(
                _screens[index],
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkText
                      : AppColors.lightText,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
    }
  }

  Widget _buildDynamicIslandNavBar() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E).withOpacity(0.8),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 25,
                  spreadRadius: 0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(icon: Icons.home, label: 'Dashboard', index: 0),
                _buildNavItem(icon: Icons.description_outlined, label: 'Income', index: 1),
                _buildNavItem(icon: Icons.track_changes_sharp, label: 'Finances', index: 2),
                _buildNavItem(icon: Icons.hub, label: 'AI', index: 3),
                _buildNavItem(icon: Icons.settings, label: 'Settings', index: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
                ? Colors.white.withOpacity(0.15)
                : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          icon,
          color: isSelected
                ? Colors.white
                : Colors.white.withOpacity(0.5),
          size: 24,
        ),
      ),
    );
  }
}
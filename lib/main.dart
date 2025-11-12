import 'package:flutter/material.dart';
import 'colors.dart';

void main() {
  runApp(const CrefinApp());
}

class CrefinApp extends StatelessWidget {
  const CrefinApp({super.key});

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
        cardColor: AppColors.lightCard
      ),

      themeMode: ThemeMode.system,

      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
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
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Center(
            child: Text(
              _screens[_currentIndex],
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
      ),
      bottomNavigationBar: _buildDynamicIslandNavBar(),
    );
  }

  Widget _buildDynamicIslandNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 10)
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: 'Dashboard',
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.description_outlined,
            label: 'Income',
            index: 1,
          ),
          _buildNavItem(
            icon: Icons.track_changes_sharp,
            label: 'Finances',
            index: 2,
          ),
          _buildNavItem(
            icon: Icons.hub,
            label: 'AI',
            index: 3,
          ),
          _buildNavItem(
            icon: Icons.settings,
            label: 'Settings',
            index: 4,
          ),
        ],
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

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                    ? Colors.white                    // Full white if selected
                    : Colors.white.withOpacity(0.5),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}


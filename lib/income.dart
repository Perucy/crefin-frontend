import 'package:flutter/material.dart';
import '../colors.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            overscroll: false,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Test content - lots of text boxes to test scrolling
                          for (int i = 1; i <= 15; i++)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Income Entry #$i',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.darkText : AppColors.lightText,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'This is test content to check if scrolling works properly. The navbar should float on top and you should be able to scroll to see all entries.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$${(i * 250).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
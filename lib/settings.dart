import 'package:flutter/material.dart';
import 'colors.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  
  const SettingsScreen({super.key, required this.onToggleTheme});

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
                            'Settings',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Profile Information
                          _buildSettingsCard(
                            context: context,
                            title: 'Profile Information',
                            isDark: isDark,
                            children: [
                              _buildSettingRow(
                                context: context,
                                icon: Icons.person,
                                label: 'Full Name',
                                value: 'Jane Cooper',
                                iconBg: AppColors.lightBorder,
                                iconColor: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              _buildSettingRow(
                                context: context,
                                icon: Icons.email,
                                label: 'Email',
                                value: 'jane@crefin.app',
                                iconBg: AppColors.lightBorder,
                                iconColor: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              _buildSettingRow(
                                context: context,
                                icon: Icons.work,
                                label: 'Profession',
                                value: 'Freelance Designer',
                                iconBg: AppColors.lightBorder,
                                iconColor: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                isDark: isDark,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Invoice Settings
                          _buildSettingsCard(
                            context: context, 
                            title: 'Invoice Settings', 
                            isDark: isDark, 
                            children: [
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.percent, 
                                label: 'Default Tax Rate', 
                                value: '8.5%', 
                                iconBg: AppColors.blue.withOpacity(0.1),
                                iconColor: AppColors.blue, 
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.calendar_today_outlined, 
                                label: 'Payment Terms', 
                                value: 'Net 30', 
                                iconBg: AppColors.blue.withOpacity(0.1),
                                iconColor: AppColors.blue, 
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.percent, 
                                label: 'Late Fee', 
                                value: '5% after 15 Days', 
                                iconBg: AppColors.blue.withOpacity(0.1),
                                iconColor: AppColors.blue, 
                                isDark: isDark,
                              ),
                            ]
                          ),
                          const SizedBox(height: 16),

                          // Tax Settings
                          _buildSettingsCard(
                            context: context, 
                            title: 'Tax Settings', 
                            isDark: isDark, 
                            children: [
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.percent, 
                                label: 'Tax Rate', 
                                value: '25% (Self-Employed)', 
                                iconBg: AppColors.purple.withOpacity(0.1),
                                iconColor: AppColors.purple, 
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.description_outlined, 
                                label: 'Quarterly Estimates', 
                                value: 'Enabled', 
                                iconBg: AppColors.purple.withOpacity(0.1),
                                iconColor: AppColors.purple, 
                                isDark: isDark,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Preferences
                          _buildSettingsCard(
                            context: context, 
                            title: 'Preferences', 
                            isDark: isDark, 
                            children: [
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.notifications_outlined, 
                                label: 'Notifications', 
                                value: '',
                                iconBg: AppColors.purple.withOpacity(0.1),
                                iconColor: AppColors.purple, 
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              
                              GestureDetector(
                                onTap: onToggleTheme,  // Call the theme toggle
                                child: _builDarkModeToggle(
                                  context: context, 
                                  isDark: isDark
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Data & Privacy
                          _buildSettingsCard(
                            context: context, 
                            title: 'Data & Privacy', 
                            isDark: isDark, 
                            children: [
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.download, 
                                label: 'Export Data', 
                                value: '', 
                                iconBg: AppColors.green.withOpacity(0.1),
                                iconColor: AppColors.green, 
                                isDark: isDark,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Danger Zone
                          _buildSettingsCard(
                            context: context, 
                            title: 'Danger Zone', 
                            isDark: isDark, 
                            children: [
                              _buildSettingRow(
                                context: context, 
                                icon: Icons.delete, 
                                label: 'Delete Account', 
                                value: '', 
                                iconBg: AppColors.red.withOpacity(0.1),
                                iconColor: AppColors.red, 
                                isDark: isDark,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Sign Out Button
                          GestureDetector(
                            onTap: () {
                              // TODO: Add sign out logic
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1C1E),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                'Sign Out',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
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

  // build a settings card
  Widget _buildSettingsCard({
    required BuildContext context,
    required String title,
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
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
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  // build a setting row
  Widget _buildSettingRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Color iconBg,
    required Color iconColor,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: value.isEmpty
                ? Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                        ),
                      ),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                        ),
                      ),
                    ],
                  ),
          ),
          Icon(
            Icons.chevron_right,
            size: 16,
            color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
          ),
        ],
      ),
    );
  }

  // dark mode toggle row
  Widget _builDarkModeToggle({
    required BuildContext context,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isDark
                  ? AppColors.purple.withOpacity(0.1)
                  : AppColors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            size: 16,
            color: isDark ? AppColors.purple : AppColors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            isDark ? 'Light Mode' : 'Dark Mode',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
        ),
        Text(
          isDark ? 'On' : 'Off',
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.green : AppColors.lightTertiaryText,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 44,
          height: 24,
          decoration: BoxDecoration(
            color: isDark ? AppColors.green : AppColors.lightBorder,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
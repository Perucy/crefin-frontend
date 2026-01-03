import 'package:flutter/material.dart';
import '../../widgets/logo.dart';
import '../../widgets/custom_text_field.dart';
import '../../colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _acceptedTerms = false;
  bool _isLoading = false;
  String _error = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Password strength calculation
  Map<String, dynamic> _getPasswordStrength(String password) {
    if (password.isEmpty) {
      return {'strength': 0, 'label': '', 'color': Colors.grey};
    }

    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[a-z]').hasMatch(password) && RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) strength++;

    if (strength <= 1) return {'strength': 0.25, 'label': 'Weak', 'color': const Color(0xFFFF3B30)};
    if (strength == 2) return {'strength': 0.5, 'label': 'Fair', 'color': const Color(0xFFFF9500)};
    if (strength == 3) return {'strength': 0.75, 'label': 'Good', 'color': const Color(0xFF007AFF)};
    return {'strength': 1.0, 'label': 'Strong', 'color': const Color(0xFF34C759)};
  }

  Future<void> _handleRegister() async {
    setState(() {
      _error = '';
    });

    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _error = 'Please fill in all required fields';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _error = 'Passwords do not match';
      });
      return;
    }

    if (!_acceptedTerms) {
      setState(() {
        _error = 'Please accept the terms and conditions';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration functionality coming soon!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final cardBg = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryText = isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final passwordStrength = _getPasswordStrength(_passwordController.text);
    final passwordsMatch = _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              const Center(
                child: Logo(size: LogoSize.medium),
              ),
              const SizedBox(height: 24),

              // Header
              Center(
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start managing your finances smarter',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Full Name
              CustomTextField(
                icon: Icons.person_outline,
                placeholder: 'Full Name',
                controller: _fullNameController,
                backgroundColor: cardBg,
                borderColor: borderColor,
                textColor: textColor,
                iconColor: secondaryText,
              ),
              const SizedBox(height: 16),

              // Email
              CustomTextField(
                icon: Icons.email_outlined,
                placeholder: 'Email address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                backgroundColor: cardBg,
                borderColor: borderColor,
                textColor: textColor,
                iconColor: secondaryText,
              ),
              const SizedBox(height: 16),

              // Phone
              CustomTextField(
                icon: Icons.phone_outlined,
                placeholder: 'Phone Number (optional)',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                backgroundColor: cardBg,
                borderColor: borderColor,
                textColor: textColor,
                iconColor: secondaryText,
              ),
              const SizedBox(height: 16),

              // Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    icon: Icons.lock_outline,
                    placeholder: 'Password',
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    backgroundColor: cardBg,
                    borderColor: borderColor,
                    textColor: textColor,
                    iconColor: secondaryText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: secondaryText,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  if (_passwordController.text.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Password Strength',
                                style: TextStyle(
                                  color: secondaryText,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                passwordStrength['label'],
                                style: TextStyle(
                                  color: passwordStrength['color'],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: passwordStrength['strength'],
                              backgroundColor: borderColor,
                              color: passwordStrength['color'],
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              // Confirm Password
              CustomTextField(
                icon: Icons.lock_outline,
                placeholder: 'Confirm Password',
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPassword,
                backgroundColor: cardBg,
                borderColor: borderColor,
                textColor: textColor,
                iconColor: secondaryText,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _showConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: secondaryText,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                    if (_confirmPasswordController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          passwordsMatch ? Icons.check_circle : Icons.cancel,
                          color: passwordsMatch ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Terms Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _acceptedTerms = !_acceptedTerms;
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: _acceptedTerms ? const Color(0xFF34C759) : cardBg,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: _acceptedTerms ? const Color(0xFF34C759) : borderColor,
                          width: 1.5,
                        ),
                      ),
                      child: _acceptedTerms
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: secondaryText, fontSize: 14),
                        children: const [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(
                              color: Color(0xFF34C759),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Color(0xFF34C759),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Error Message
              if (_error.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _error,
                    style: const TextStyle(
                      color: Color(0xFFFF3B30),
                      fontSize: 14,
                    ),
                  ),
                ),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34C759),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFF34C759).withOpacity(0.3),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Login Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF34C759),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
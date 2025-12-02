import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/user_model.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/providers/onboarding_provider.dart';

/// Email sign up screen
class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final userProvider = context.read<UserProvider>();
    final onboardingProvider = context.read<OnboardingProvider>();
    
    final success = await userProvider.signUpWithEmail(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      age: int.tryParse(_ageController.text.trim()) ?? 18,
      email: _emailController.text.trim(),
      password: _passwordController.text,
      schoolStage: onboardingProvider.selectedSchoolStage ?? SchoolStage.high,
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => context.go('/auth/create-account'),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Create your account',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: isDark 
                        ? AppColors.darkTextPrimary 
                        : AppColors.lightTextPrimary,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // First Name
                _buildTextField(
                  controller: _firstNameController,
                  label: 'First name',
                  hint: 'Enter your first name',
                  isDark: isDark,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Last Name
                _buildTextField(
                  controller: _lastNameController,
                  label: 'Last name',
                  hint: 'Enter your last name',
                  isDark: isDark,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Age
                _buildTextField(
                  controller: _ageController,
                  label: 'Age',
                  hint: 'Enter your age',
                  isDark: isDark,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 13 || age > 120) {
                      return 'Please enter a valid age (13+)';
                    }
                    return null;
                  },
                ),
                
                // Age note
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Text(
                    'We ask for age only to customize your experience and stay compliant with local rules.',
                    style: TextStyle(fontFamily: 'Satoshi', 
                      fontSize: 12,
                      color: isDark 
                          ? AppColors.darkTextSecondary 
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Email
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  isDark: isDark,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Password
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Create a password',
                  isDark: isDark,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword 
                          ? Icons.visibility_outlined 
                          : Icons.visibility_off_outlined,
                      color: isDark 
                          ? AppColors.darkTextSecondary 
                          : AppColors.lightTextSecondary,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please create a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Sign up button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? AppColors.accentPrimary : Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      disabledBackgroundColor: isDark 
                          ? AppColors.darkCardSurface 
                          : AppColors.lightCardSurface,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDark ? Colors.white : AppColors.accentPrimary,
                              ),
                            ),
                          )
                        : Text(
                            'Sign up',
                            style: TextStyle(fontFamily: 'Satoshi', 
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Sign in link
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/auth/signin'),
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 14,
                          color: isDark 
                              ? AppColors.darkTextSecondary 
                              : AppColors.lightTextSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(fontFamily: 'Satoshi', 
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'Satoshi', 
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark 
                ? AppColors.darkTextPrimary 
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(fontFamily: 'Satoshi', 
            fontSize: 16,
            color: isDark 
                ? AppColors.darkTextPrimary 
                : AppColors.lightTextPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontFamily: 'Satoshi', 
              fontSize: 16,
              color: isDark 
                  ? AppColors.darkTextSecondary 
                  : AppColors.lightTextSecondary,
            ),
            filled: true,
            fillColor: isDark 
                ? AppColors.darkCardSurface 
                : AppColors.lightCardSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark 
                    ? AppColors.darkBorderSubtle 
                    : AppColors.lightBorderSubtle,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark 
                    ? AppColors.darkBorderSubtle 
                    : AppColors.lightBorderSubtle,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.accentPrimary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.destructive,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

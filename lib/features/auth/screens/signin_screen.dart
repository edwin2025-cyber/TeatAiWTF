import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/providers/user_provider.dart';

/// Sign in screen
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final userProvider = context.read<UserProvider>();
    
    final success = await userProvider.signInWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text,
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
                  'Sign in',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: isDark 
                        ? AppColors.darkTextPrimary 
                        : AppColors.lightTextPrimary,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Social buttons row
                Row(
                  children: [
                    Expanded(
                      child: _SocialSignInButton(
                        icon: _GoogleIcon(),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Google auth coming soon!')),
                          );
                        },
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SocialSignInButton(
                        icon: Icon(
                          Icons.apple,
                          size: 28,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Apple auth coming soon!')),
                          );
                        },
                        isDark: isDark,
                        isApple: true,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Divider with OR
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDark 
                            ? AppColors.darkBorderSubtle 
                            : AppColors.lightBorderSubtle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark 
                              ? AppColors.darkTextSecondary 
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDark 
                            ? AppColors.darkBorderSubtle 
                            : AppColors.lightBorderSubtle,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
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
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Password
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
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
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 8),
                
                // Forgot password link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Forgot password coming soon!')),
                      );
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(fontFamily: 'Satoshi', 
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.accentPrimary,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Sign in button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentPrimary,
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
                            'Sign in',
                            style: TextStyle(fontFamily: 'Satoshi', 
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Sign up link
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/auth/signup/email'),
                    child: Text.rich(
                      TextSpan(
                        text: 'No account yet? ',
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 14,
                          color: isDark 
                              ? AppColors.darkTextSecondary 
                              : AppColors.lightTextSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign up',
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

class _SocialSignInButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final bool isDark;
  final bool isApple;

  const _SocialSignInButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
    this.isApple = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: isApple 
                ? (isDark ? Colors.white : Colors.black)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark 
                  ? AppColors.darkBorderSubtle 
                  : AppColors.lightBorderSubtle,
            ),
          ),
          child: Center(
            child: isApple
                ? Icon(
                    Icons.apple,
                    size: 28,
                    color: isDark ? Colors.black : Colors.white,
                  )
                : icon,
          ),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _GoogleIconPainter(),
      ),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    
    // Google G colors
    final bluePaint = Paint()..color = const Color(0xFF4285F4);
    final redPaint = Paint()..color = const Color(0xFFEA4335);
    final yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    final greenPaint = Paint()..color = const Color(0xFF34A853);

    // Draw simplified Google G
    final path = Path();
    
    // Blue arc (right side)
    path.moveTo(w * 0.95, h * 0.5);
    path.arcToPoint(
      Offset(w * 0.5, h * 0.05),
      radius: Radius.circular(w * 0.45),
      clockwise: false,
    );
    path.lineTo(w * 0.5, h * 0.25);
    path.arcToPoint(
      Offset(w * 0.75, h * 0.5),
      radius: Radius.circular(w * 0.25),
      clockwise: true,
    );
    path.lineTo(w * 0.95, h * 0.5);
    canvas.drawPath(path, bluePaint);
    
    // Red arc (top left)
    final redPath = Path();
    redPath.moveTo(w * 0.5, h * 0.05);
    redPath.arcToPoint(
      Offset(w * 0.05, h * 0.5),
      radius: Radius.circular(w * 0.45),
      clockwise: false,
    );
    redPath.lineTo(w * 0.25, h * 0.5);
    redPath.arcToPoint(
      Offset(w * 0.5, h * 0.25),
      radius: Radius.circular(w * 0.25),
      clockwise: true,
    );
    canvas.drawPath(redPath, redPaint);
    
    // Yellow arc (bottom left)
    final yellowPath = Path();
    yellowPath.moveTo(w * 0.05, h * 0.5);
    yellowPath.arcToPoint(
      Offset(w * 0.5, h * 0.95),
      radius: Radius.circular(w * 0.45),
      clockwise: false,
    );
    yellowPath.lineTo(w * 0.5, h * 0.75);
    yellowPath.arcToPoint(
      Offset(w * 0.25, h * 0.5),
      radius: Radius.circular(w * 0.25),
      clockwise: true,
    );
    canvas.drawPath(yellowPath, yellowPaint);
    
    // Green arc (bottom right)
    final greenPath = Path();
    greenPath.moveTo(w * 0.5, h * 0.95);
    greenPath.arcToPoint(
      Offset(w * 0.95, h * 0.5),
      radius: Radius.circular(w * 0.45),
      clockwise: false,
    );
    greenPath.lineTo(w * 0.75, h * 0.5);
    greenPath.arcToPoint(
      Offset(w * 0.5, h * 0.75),
      radius: Radius.circular(w * 0.25),
      clockwise: true,
    );
    canvas.drawPath(greenPath, greenPaint);
    
    // Blue rectangle
    canvas.drawRect(
      Rect.fromLTWH(w * 0.5, h * 0.4, w * 0.45, h * 0.2),
      bluePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

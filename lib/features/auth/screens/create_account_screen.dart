import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

/// Create account screen with social auth options
class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
          onPressed: () => context.go('/onboarding/school'),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Create your account',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Subtitle
              Text(
                'Save your progress, track your civic journey, and pick up right where you left off across devices.',
                style: TextStyle(fontFamily: 'Satoshi', 
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isDark 
                      ? AppColors.darkTextSecondary 
                      : AppColors.lightTextSecondary,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Continue with Google
              _SocialButton(
                label: 'Continue with Google',
                iconWidget: _GoogleIcon(),
                onTap: () {
                  // TODO: Implement Google auth
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Google auth coming soon!')),
                  );
                },
                isDark: isDark,
                isGoogle: true,
              ),
              
              const SizedBox(height: 12),
              
              // Continue with Apple
              _SocialButton(
                label: 'Continue with Apple',
                iconWidget: Icon(
                  Icons.apple,
                  size: 24,
                  color: isDark ? Colors.black : Colors.white,
                ),
                onTap: () {
                  // TODO: Implement Apple auth
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Apple auth coming soon!')),
                  );
                },
                isDark: isDark,
                isApple: true,
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
              
              // Continue with email
              _SocialButton(
                label: 'Continue with email',
                iconWidget: Icon(
                  Icons.email_outlined,
                  size: 24,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onTap: () => context.go('/auth/signup/email'),
                isDark: isDark,
                isEmail: true,
              ),
              
              const Spacer(),
              
              // Existing user link
              Center(
                child: TextButton(
                  onPressed: () => context.go('/auth/signin'),
                  child: Text.rich(
                    TextSpan(
                      text: 'Existing user? ',
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
              
              const SizedBox(height: 16),
              
              // Terms text
              Text(
                'By continuing, you agree to WeTheFuture\'s Terms of Service and Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Satoshi', 
                  fontSize: 12,
                  color: isDark 
                      ? AppColors.darkTextSecondary 
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget iconWidget;
  final VoidCallback onTap;
  final bool isDark;
  final bool isGoogle;
  final bool isApple;
  final bool isEmail;

  const _SocialButton({
    required this.label,
    required this.iconWidget,
    required this.onTap,
    required this.isDark,
    this.isGoogle = false,
    this.isApple = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color? borderColor;

    if (isGoogle) {
      backgroundColor = Colors.white;
      textColor = Colors.black;
      borderColor = AppColors.lightBorderSubtle;
    } else if (isApple) {
      backgroundColor = Colors.black;
      textColor = Colors.white;
      borderColor = null;
    } else if (isEmail) {
      backgroundColor = isDark ? const Color(0xFF111827) : Colors.white;
      textColor = isDark ? Colors.white : Colors.black;
      borderColor = isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle;
    } else {
      backgroundColor = isDark ? AppColors.darkCardSurface : AppColors.lightCardSurface;
      textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
      borderColor = isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(9999),
            border: borderColor != null 
                ? Border.all(color: borderColor)
                : null,
            boxShadow: isGoogle ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget,
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(fontFamily: 'Satoshi', 
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

/// Intro screen - "Learn by doing" style hero screen
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  
                  // Headline
                  Text(
                    'Learn your future by understanding your country.',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: isDark 
                          ? AppColors.darkTextPrimary 
                          : AppColors.lightTextPrimary,
                      height: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Subheadline
                  Text(
                    'Interactive civics, local issues, and real actions you can take – in just a few minutes a day.',
                    style: TextStyle(fontFamily: 'Satoshi', 
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: isDark 
                          ? AppColors.darkTextSecondary 
                          : AppColors.lightTextSecondary,
                      height: 1.5,
                    ),
                  ),
                  
                  const Spacer(flex: 1),
                  
                  // Illustration placeholder
                  Center(
                    child: Container(
                      width: size.width * 0.8,
                      height: size.width * 0.6,
                      decoration: BoxDecoration(
                        color: isDark 
                            ? AppColors.darkCardSurface 
                            : AppColors.lightCardSurface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark 
                              ? AppColors.darkBorderSubtle 
                              : AppColors.lightBorderSubtle,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.how_to_vote_outlined,
                            size: 64,
                            color: AppColors.accentPrimary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Civic Education',
                            style: TextStyle(fontFamily: 'Satoshi', 
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDark 
                                  ? AppColors.darkTextSecondary 
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Spacer(flex: 2),
                  
                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.go('/onboarding/school'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentPrimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

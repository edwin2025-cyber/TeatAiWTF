import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/user_model.dart';
import '../../../core/providers/onboarding_provider.dart';

/// School status selection screen
class SchoolStatusScreen extends StatelessWidget {
  const SchoolStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Consumer<OnboardingProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: provider.progress,
                          backgroundColor: isDark 
                              ? AppColors.darkBorderSubtle 
                              : AppColors.lightBorderSubtle,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accentPrimary,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark 
                            ? AppColors.accentSubtleDark 
                            : AppColors.accentSubtleLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Welcome — let\'s personalize WeTheFuture',
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentPrimary,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Question
                    Text(
                      'Let\'s get to know you — where are you in school right now?',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: isDark 
                            ? AppColors.darkTextPrimary 
                            : AppColors.lightTextPrimary,
                        height: 1.2,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Options
                    Consumer<OnboardingProvider>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            _SchoolOptionCard(
                              stage: SchoolStage.middle,
                              icon: Icons.menu_book_outlined,
                              isSelected: provider.selectedSchoolStage == SchoolStage.middle,
                              onTap: () => provider.setSchoolStage(SchoolStage.middle),
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _SchoolOptionCard(
                              stage: SchoolStage.high,
                              icon: Icons.school_outlined,
                              isSelected: provider.selectedSchoolStage == SchoolStage.high,
                              onTap: () => provider.setSchoolStage(SchoolStage.high),
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _SchoolOptionCard(
                              stage: SchoolStage.college,
                              icon: Icons.account_balance_outlined,
                              isSelected: provider.selectedSchoolStage == SchoolStage.college,
                              onTap: () => provider.setSchoolStage(SchoolStage.college),
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _SchoolOptionCard(
                              stage: SchoolStage.none,
                              icon: Icons.explore_outlined,
                              isSelected: provider.selectedSchoolStage == SchoolStage.none,
                              onTap: () => provider.setSchoolStage(SchoolStage.none),
                              isDark: isDark,
                              iconColor: AppColors.destructive,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            // Continue button
            Padding(
              padding: const EdgeInsets.all(24),
              child: Consumer<OnboardingProvider>(
                builder: (context, provider, child) {
                  final isEnabled = provider.selectedSchoolStage != null;
                  
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: isEnabled 
                          ? () => context.go('/auth/create-account')
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEnabled 
                            ? AppColors.accentPrimary 
                            : (isDark 
                                ? AppColors.darkCardSurface 
                                : AppColors.lightCardSurface),
                        foregroundColor: isEnabled 
                            ? Colors.white 
                            : (isDark 
                                ? AppColors.darkTextSecondary 
                                : AppColors.lightTextSecondary),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        disabledBackgroundColor: isDark 
                            ? AppColors.darkCardSurface 
                            : AppColors.lightCardSurface,
                        disabledForegroundColor: isDark 
                            ? AppColors.darkTextSecondary 
                            : AppColors.lightTextSecondary,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SchoolOptionCard extends StatelessWidget {
  final SchoolStage stage;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  final Color? iconColor;

  const _SchoolOptionCard({
    required this.stage,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected 
              ? (isDark ? AppColors.accentSubtleDark : AppColors.accentSubtleLight)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected 
                ? AppColors.accentPrimary 
                : (isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected 
              ? [
                  BoxShadow(
                    color: AppColors.accentPrimary.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark 
                    ? AppColors.darkCardSurface 
                    : AppColors.lightCardSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 24,
                color: iconColor ?? AppColors.accentPrimary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage.displayName,
                    style: TextStyle(fontFamily: 'Satoshi', 
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark 
                          ? AppColors.darkTextPrimary 
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stage.subtitle,
                    style: TextStyle(fontFamily: 'Satoshi', 
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark 
                          ? AppColors.darkTextSecondary 
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.accentPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/providers/user_provider.dart';

/// Home screen - Dashboard
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Header
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final userName = userProvider.user?.name.split(' ').first ?? 'there';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_getGreeting()}, $userName.',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: isDark 
                              ? AppColors.darkTextPrimary 
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Here's what's happening near you.",
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 16,
                          color: isDark 
                              ? AppColors.darkTextSecondary 
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              // Today's Civic Snapshot
              _SectionCard(
                title: "Today's Civic Snapshot",
                isDark: isDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Local',
                            style: TextStyle(fontFamily: 'Satoshi', 
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Education',
                            style: TextStyle(fontFamily: 'Satoshi', 
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'School board meeting tomorrow at 6 PM',
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
                      'Agenda includes student mental health funding and new curriculum proposals.',
                      style: TextStyle(fontFamily: 'Satoshi', 
                        fontSize: 14,
                        color: isDark 
                            ? AppColors.darkTextSecondary 
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Understand this →',
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Your Journey
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final user = userProvider.user;
                  final xp = user?.xp ?? 0;
                  final level = user?.currentLevel ?? 1;
                  final civicLevel = user?.civicLevel ?? 'Curious Citizen';
                  final progress = user?.levelProgress ?? 0.0;
                  final xpForNext = user?.xpForNextLevel ?? 50;
                  
                  return _SectionCard(
                    title: 'Your Journey',
                    isDark: isDark,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.accentPrimary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '$level',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Civic Level $level – $civicLevel',
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
                                    '$xp / $xpForNext XP until next badge',
                                    style: TextStyle(fontFamily: 'Satoshi', 
                                      fontSize: 14,
                                      color: isDark 
                                          ? AppColors.darkTextSecondary 
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: isDark 
                                ? AppColors.darkBorderSubtle 
                                : AppColors.lightBorderSubtle,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.accentPrimary,
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // Continue Learning
              Text(
                'Continue learning',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _LearningCard(
                      title: 'Intro to Elections',
                      subtitle: 'Continue',
                      progress: 0.3,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _LearningCard(
                      title: 'Branches of Government',
                      subtitle: 'Quiz',
                      progress: 0.7,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _LearningCard(
                      title: 'City Council 101',
                      subtitle: 'Lesson',
                      progress: 0.0,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Quick Actions
              Text(
                'Quick actions',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _QuickActionChip(
                    label: 'Find my representatives',
                    onTap: () {},
                    isDark: isDark,
                  ),
                  _QuickActionChip(
                    label: 'Check upcoming elections',
                    onTap: () {},
                    isDark: isDark,
                  ),
                  _QuickActionChip(
                    label: 'Take a 5-min civics quiz',
                    onTap: () {},
                    isDark: isDark,
                  ),
                ],
              ),
              
              const SizedBox(height: 100), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isDark;

  const _SectionCard({
    required this.title,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardSurface : AppColors.lightCardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark 
                  ? AppColors.darkTextSecondary 
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _LearningCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final bool isDark;

  const _LearningCard({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardSurface : AppColors.lightCardSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              subtitle,
              style: TextStyle(fontFamily: 'Satoshi', 
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontFamily: 'Satoshi', 
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark 
                  ? AppColors.darkTextPrimary 
                  : AppColors.lightTextPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
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
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _QuickActionChip({
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.darkCardSurface 
                : AppColors.lightCardSurface,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: isDark 
                  ? AppColors.darkBorderSubtle 
                  : AppColors.lightBorderSubtle,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontFamily: 'Satoshi', 
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark 
                  ? AppColors.darkTextPrimary 
                  : AppColors.lightTextPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

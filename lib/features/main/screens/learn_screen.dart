import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

/// Learn screen - Courses and lessons
class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

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
              // Header
              Text(
                'Learn civics, one lesson at a time.',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                  height: 1.2,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Daily goal
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark 
                      ? AppColors.darkCardSurface 
                      : AppColors.lightCardSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark 
                        ? AppColors.darkBorderSubtle 
                        : AppColors.lightBorderSubtle,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: AppColors.accentPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Daily goal: 10 min / day',
                      style: TextStyle(fontFamily: 'Satoshi', 
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark 
                            ? AppColors.darkTextPrimary 
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: isDark 
                          ? AppColors.darkTextSecondary 
                          : AppColors.lightTextSecondary,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Recommended section
              Text(
                'Recommended for you',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              _CourseCard(
                title: 'Elections 101',
                description: 'Learn how elections work in America',
                lessonsComplete: 2,
                totalLessons: 8,
                icon: Icons.how_to_vote_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _CourseCard(
                title: 'Rights & Responsibilities',
                description: 'Your constitutional rights explained',
                lessonsComplete: 0,
                totalLessons: 6,
                icon: Icons.gavel_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 32),
              
              // All Courses
              Text(
                'Pathways',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              _CourseCard(
                title: 'Foundations of US Government',
                description: 'The structure and history of our government',
                lessonsComplete: 3,
                totalLessons: 12,
                icon: Icons.account_balance_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _CourseCard(
                title: 'Understanding Elections',
                description: 'From primaries to the general election',
                lessonsComplete: 1,
                totalLessons: 8,
                icon: Icons.ballot_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _CourseCard(
                title: 'Your Local Government',
                description: 'City councils, mayors, and school boards',
                lessonsComplete: 0,
                totalLessons: 6,
                icon: Icons.location_city_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 32),
              
              // Quick Quizzes
              Text(
                'Quick quizzes',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _QuizCard(
                      title: 'Branches of Government',
                      questionCount: 5,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuizCard(
                      title: 'Your Rights',
                      questionCount: 8,
                      isDark: isDark,
                    ),
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

class _CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final int lessonsComplete;
  final int totalLessons;
  final IconData icon;
  final bool isDark;

  const _CourseCard({
    required this.title,
    required this.description,
    required this.lessonsComplete,
    required this.totalLessons,
    required this.icon,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalLessons > 0 ? lessonsComplete / totalLessons : 0.0;
    
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
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accentPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.accentPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
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
                      description,
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
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: isDark 
                        ? AppColors.darkBorderSubtle 
                        : AppColors.lightBorderSubtle,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.accentPrimary,
                    ),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$lessonsComplete/$totalLessons',
                style: TextStyle(fontFamily: 'Satoshi', 
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark 
                      ? AppColors.darkTextSecondary 
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final String title;
  final int questionCount;
  final bool isDark;

  const _QuizCard({
    required this.title,
    required this.questionCount,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Icon(
            Icons.quiz_outlined,
            color: AppColors.accentPrimary,
            size: 24,
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
          ),
          const SizedBox(height: 4),
          Text(
            '$questionCount questions',
            style: TextStyle(fontFamily: 'Satoshi', 
              fontSize: 12,
              color: isDark 
                  ? AppColors.darkTextSecondary 
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

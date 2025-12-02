import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

/// Explore screen - States, Issues, Representatives
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
                'Explore',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark 
                      ? AppColors.darkCardSurface 
                      : AppColors.lightCardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark 
                        ? AppColors.darkBorderSubtle 
                        : AppColors.lightBorderSubtle,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: isDark 
                          ? AppColors.darkTextSecondary 
                          : AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Search states, issues, or people',
                      style: TextStyle(fontFamily: 'Satoshi', 
                        fontSize: 16,
                        color: isDark 
                            ? AppColors.darkTextSecondary 
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Use my location
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.accentPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.my_location,
                      size: 18,
                      color: AppColors.accentPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Use my location',
                      style: TextStyle(fontFamily: 'Satoshi', 
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // States Section
              Text(
                'States',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // States grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _StateCard(abbreviation: 'AL', name: 'Alabama', isDark: isDark),
                  _StateCard(abbreviation: 'CA', name: 'California', isDark: isDark),
                  _StateCard(abbreviation: 'TX', name: 'Texas', isDark: isDark),
                  _StateCard(abbreviation: 'FL', name: 'Florida', isDark: isDark),
                  _StateCard(abbreviation: 'NY', name: 'New York', isDark: isDark),
                  _StateCard(abbreviation: '50+', name: 'View all', isDark: isDark, isViewAll: true),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Issues Section
              Text(
                'Issues',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              _IssueCard(
                title: 'Education',
                description: 'School funding, curriculum, and student outcomes',
                icon: Icons.school_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _IssueCard(
                title: 'Climate & Environment',
                description: 'Environmental policy and sustainability',
                icon: Icons.eco_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _IssueCard(
                title: 'Civil Rights',
                description: 'Equality, voting rights, and justice',
                icon: Icons.balance_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _IssueCard(
                title: 'Technology & Privacy',
                description: 'Digital rights and data protection',
                icon: Icons.security_outlined,
                isDark: isDark,
              ),
              
              const SizedBox(height: 32),
              
              // Representatives Section
              Text(
                'Your Representatives',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              _RepresentativeCard(
                name: 'Senator Jane Smith',
                role: 'U.S. Senator',
                party: 'D',
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _RepresentativeCard(
                name: 'Rep. John Doe',
                role: 'U.S. Representative, District 5',
                party: 'R',
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _RepresentativeCard(
                name: 'Mayor Lisa Johnson',
                role: 'City Mayor',
                party: 'I',
                isDark: isDark,
              ),
              
              const SizedBox(height: 100), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  final String abbreviation;
  final String name;
  final bool isDark;
  final bool isViewAll;

  const _StateCard({
    required this.abbreviation,
    required this.name,
    required this.isDark,
    this.isViewAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isViewAll 
            ? AppColors.accentPrimary.withOpacity(0.1)
            : (isDark ? AppColors.darkCardSurface : AppColors.lightCardSurface),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isViewAll 
              ? AppColors.accentPrimary.withOpacity(0.3)
              : (isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            abbreviation,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isViewAll 
                  ? AppColors.accentPrimary
                  : (isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(fontFamily: 'Satoshi', 
              fontSize: 11,
              color: isViewAll 
                  ? AppColors.accentPrimary
                  : (isDark 
                      ? AppColors.darkTextSecondary 
                      : AppColors.lightTextSecondary),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _IssueCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isDark;

  const _IssueCard({
    required this.title,
    required this.description,
    required this.icon,
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
      child: Row(
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
          Icon(
            Icons.chevron_right,
            color: isDark 
                ? AppColors.darkTextSecondary 
                : AppColors.lightTextSecondary,
          ),
        ],
      ),
    );
  }
}

class _RepresentativeCard extends StatelessWidget {
  final String name;
  final String role;
  final String party;
  final bool isDark;

  const _RepresentativeCard({
    required this.name,
    required this.role,
    required this.party,
    required this.isDark,
  });

  Color get partyColor {
    switch (party) {
      case 'D':
        return const Color(0xFF2563EB); // Blue for Democrat
      case 'R':
        return const Color(0xFFDC2626); // Red for Republican
      default:
        return const Color(0xFF7C3AED); // Purple for Independent
    }
  }

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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: partyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                party,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: partyColor,
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
                  name,
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
                  role,
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
          Icon(
            Icons.chevron_right,
            color: isDark 
                ? AppColors.darkTextSecondary 
                : AppColors.lightTextSecondary,
          ),
        ],
      ),
    );
  }
}

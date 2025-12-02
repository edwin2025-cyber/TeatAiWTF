import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/models/user_model.dart';

/// Profile screen - User settings and account
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              // Profile Header
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final user = userProvider.user;
                  final initials = user?.name.isNotEmpty == true
                      ? user!.name.split(' ').map((n) => n.isNotEmpty ? n[0] : '').take(2).join()
                      : 'U';
                  
                  return Row(
                    children: [
                      // Avatar
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.accentPrimary,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Center(
                          child: Text(
                            initials.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 24,
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
                              user?.name ?? 'User',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: isDark 
                                    ? AppColors.darkTextPrimary 
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                            Text(
                              '${user?.schoolStage.displayName ?? 'Student'} • ${user?.location?.statePostal ?? 'US'}',
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
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              // Progress Section
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final user = userProvider.user;
                  return _SectionCard(
                    title: 'Progress',
                    isDark: isDark,
                    child: Row(
                      children: [
                        _StatItem(
                          value: '${user?.xp ?? 0}',
                          label: 'XP Earned',
                          isDark: isDark,
                        ),
                        const SizedBox(width: 32),
                        _StatItem(
                          value: '${user?.streakDays ?? 0}',
                          label: 'Day Streak',
                          isDark: isDark,
                        ),
                        const SizedBox(width: 32),
                        _StatItem(
                          value: '${user?.completedLessons.length ?? 0}',
                          label: 'Lessons',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // Appearance Section
              Text(
                'Appearance',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 12),
              
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Container(
                    padding: const EdgeInsets.all(4),
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
                        _ThemeOption(
                          label: 'Light',
                          isSelected: themeProvider.themeMode == ThemeMode.light,
                          onTap: () => themeProvider.setThemeMode(ThemeMode.light),
                          isDark: isDark,
                        ),
                        _ThemeOption(
                          label: 'Dark',
                          isSelected: themeProvider.themeMode == ThemeMode.dark,
                          onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
                          isDark: isDark,
                        ),
                        _ThemeOption(
                          label: 'System',
                          isSelected: themeProvider.themeMode == ThemeMode.system,
                          onTap: () => themeProvider.setThemeMode(ThemeMode.system),
                          isDark: isDark,
                        ),
                      ],
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // Account Section
              Text(
                'Account',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 12),
              
              _SettingsCard(
                title: 'Email',
                subtitle: context.watch<UserProvider>().user?.email ?? 'Not set',
                icon: Icons.email_outlined,
                onTap: () {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _SettingsCard(
                title: 'Manage sign-in methods',
                subtitle: 'Google, Apple, Email',
                icon: Icons.key_outlined,
                onTap: () {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 24),
              
              // Notifications Section
              Text(
                'Notifications',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 12),
              
              _ToggleSettingsCard(
                title: 'Daily civic snapshot',
                isEnabled: true,
                onChanged: (value) {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _ToggleSettingsCard(
                title: 'New local issues',
                isEnabled: true,
                onChanged: (value) {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _ToggleSettingsCard(
                title: 'Streak reminders',
                isEnabled: false,
                onChanged: (value) {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 24),
              
              // Legal Section
              Text(
                'Legal & About',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
              
              const SizedBox(height: 12),
              
              _SettingsCard(
                title: 'Terms of Service',
                icon: Icons.description_outlined,
                onTap: () {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _SettingsCard(
                title: 'Privacy Policy',
                icon: Icons.privacy_tip_outlined,
                onTap: () {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 12),
              
              _SettingsCard(
                title: 'About WeTheFuture',
                icon: Icons.info_outline,
                onTap: () {},
                isDark: isDark,
              ),
              
              const SizedBox(height: 32),
              
              // Sign Out Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () async {
                    await context.read<UserProvider>().signOut();
                    if (context.mounted) {
                      context.go('/splash');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.destructive,
                    side: const BorderSide(color: AppColors.destructive),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  child: Text(
                    'Sign out',
                    style: TextStyle(fontFamily: 'Satoshi', 
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;

  const _StatItem({
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.accentPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontFamily: 'Satoshi', 
            fontSize: 12,
            color: isDark 
                ? AppColors.darkTextSecondary 
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _ThemeOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accentPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontFamily: 'Satoshi', 
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected 
                    ? Colors.white 
                    : (isDark 
                        ? AppColors.darkTextSecondary 
                        : AppColors.lightTextSecondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _SettingsCard({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCardSurface : AppColors.lightCardSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: isDark 
                    ? AppColors.darkTextSecondary 
                    : AppColors.lightTextSecondary,
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
                        fontWeight: FontWeight.w500,
                        color: isDark 
                            ? AppColors.darkTextPrimary 
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(fontFamily: 'Satoshi', 
                          fontSize: 14,
                          color: isDark 
                              ? AppColors.darkTextSecondary 
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }
}

class _ToggleSettingsCard extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final bool isDark;

  const _ToggleSettingsCard({
    required this.title,
    required this.isEnabled,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardSurface : AppColors.lightCardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontFamily: 'Satoshi', 
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark 
                    ? AppColors.darkTextPrimary 
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: onChanged,
            activeColor: AppColors.accentPrimary,
          ),
        ],
      ),
    );
  }
}

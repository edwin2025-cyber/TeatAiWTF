import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_icons.dart';

/// Main app shell with bottom navigation
class MainShell extends StatefulWidget {
  final Widget child;
  
  const MainShell({
    super.key,
    required this.child,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const List<String> _routes = [
    '/home',
    '/learn',
    '/explore',
    '/you',
  ];

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
      context.go(_routes[index]);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update current index based on current route
    final location = GoRouterState.of(context).uri.path;
    final index = _routes.indexOf(location);
    if (index != -1 && index != _currentIndex) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark 
                  ? AppColors.navBarDark 
                  : AppColors.lightBorderSubtle,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: AppIcons.home(
                    size: 24,
                    color: _currentIndex == 0 
                        ? AppColors.accentPrimary 
                        : (isDark 
                            ? AppColors.darkTextSecondary 
                            : AppColors.lightTextSecondary),
                    filled: _currentIndex == 0,
                  ),
                  label: 'Home',
                  isSelected: _currentIndex == 0,
                  onTap: () => _onTabTapped(0),
                  isDark: isDark,
                ),
                _NavBarItem(
                  icon: AppIcons.book(
                    size: 24,
                    color: _currentIndex == 1 
                        ? AppColors.accentPrimary 
                        : (isDark 
                            ? AppColors.darkTextSecondary 
                            : AppColors.lightTextSecondary),
                    filled: _currentIndex == 1,
                  ),
                  label: 'Learn',
                  isSelected: _currentIndex == 1,
                  onTap: () => _onTabTapped(1),
                  isDark: isDark,
                ),
                _NavBarItem(
                  icon: AppIcons.explore(
                    size: 24,
                    color: _currentIndex == 2 
                        ? AppColors.accentPrimary 
                        : (isDark 
                            ? AppColors.darkTextSecondary 
                            : AppColors.lightTextSecondary),
                    filled: _currentIndex == 2,
                  ),
                  label: 'Explore',
                  isSelected: _currentIndex == 2,
                  onTap: () => _onTabTapped(2),
                  isDark: isDark,
                ),
                _NavBarItem(
                  icon: AppIcons.profile(
                    size: 24,
                    color: _currentIndex == 3 
                        ? AppColors.accentPrimary 
                        : (isDark 
                            ? AppColors.darkTextSecondary 
                            : AppColors.lightTextSecondary),
                    filled: _currentIndex == 3,
                  ),
                  label: 'You',
                  isSelected: _currentIndex == 3,
                  onTap: () => _onTabTapped(3),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.accentPrimary.withOpacity(0.1) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontFamily: 'Satoshi', 
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected 
                    ? AppColors.accentPrimary 
                    : (isDark 
                        ? AppColors.darkTextSecondary 
                        : AppColors.lightTextSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

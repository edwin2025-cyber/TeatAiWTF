import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/intro_screen.dart';
import '../../features/onboarding/screens/school_status_screen.dart';
import '../../features/auth/screens/create_account_screen.dart';
import '../../features/auth/screens/email_signup_screen.dart';
import '../../features/auth/screens/signin_screen.dart';
import '../../features/main/screens/main_shell.dart';
import '../../features/main/screens/home_screen.dart';
import '../../features/main/screens/learn_screen.dart';
import '../../features/main/screens/explore_screen.dart';
import '../../features/main/screens/profile_screen.dart';

/// App Router configuration using GoRouter
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      // Onboarding Routes
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/intro',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const IntroScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                )),
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: '/onboarding/school',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SchoolStatusScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      ),
      
      // Auth Routes
      GoRoute(
        path: '/auth/create-account',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CreateAccountScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: '/auth/signup/email',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const EmailSignupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: '/auth/signin',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SigninScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/learn',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LearnScreen(),
            ),
          ),
          GoRoute(
            path: '/explore',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ExploreScreen(),
            ),
          ),
          GoRoute(
            path: '/you',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import '../models/user_model.dart';

/// Provider for managing user state
class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    _isAuthenticated = true;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  void updateXp(int additionalXp) {
    if (_user != null) {
      _user = _user!.copyWith(xp: _user!.xp + additionalXp);
      notifyListeners();
    }
  }

  void updateStreak(int days) {
    if (_user != null) {
      _user = _user!.copyWith(streakDays: days);
      notifyListeners();
    }
  }

  void completeMission(String missionId) {
    if (_user != null) {
      final updatedMissions = [..._user!.completedMissions, missionId];
      _user = _user!.copyWith(completedMissions: updatedMissions);
      notifyListeners();
    }
  }

  void completeLesson(String lessonId) {
    if (_user != null) {
      final updatedLessons = [..._user!.completedLessons, lessonId];
      _user = _user!.copyWith(completedLessons: updatedLessons);
      notifyListeners();
    }
  }

  void updateLocation(UserLocation location) {
    if (_user != null) {
      _user = _user!.copyWith(location: location);
      notifyListeners();
    }
  }

  /// Simulate sign up (replace with Firebase later)
  Future<bool> signUpWithEmail({
    required String firstName,
    required String lastName,
    required int age,
    required String email,
    required String password,
    required SchoolStage schoolStage,
  }) async {
    setLoading(true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Create user (in production, this would be Firebase auth)
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '$firstName $lastName',
      age: age,
      email: email,
      schoolStage: schoolStage,
      onboardingCompleted: true,
    );
    
    setUser(newUser);
    setLoading(false);
    return true;
  }

  /// Simulate sign in (replace with Firebase later)
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    setLoading(true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate successful login
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Demo User',
      age: 18,
      email: email,
      schoolStage: SchoolStage.high,
      onboardingCompleted: true,
      xp: 42,
      streakDays: 5,
    );
    
    setUser(user);
    setLoading(false);
    return true;
  }

  /// Sign out
  Future<void> signOut() async {
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 500));
    clearUser();
    setLoading(false);
  }
}

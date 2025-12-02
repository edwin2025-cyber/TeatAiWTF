import 'package:flutter/material.dart';
import '../models/user_model.dart';

/// Provider for managing onboarding state
class OnboardingProvider extends ChangeNotifier {
  SchoolStage? _selectedSchoolStage;
  int _currentStep = 0;
  final int _totalSteps = 3;

  SchoolStage? get selectedSchoolStage => _selectedSchoolStage;
  int get currentStep => _currentStep;
  int get totalSteps => _totalSteps;
  double get progress => (_currentStep + 1) / _totalSteps;

  void setSchoolStage(SchoolStage stage) {
    _selectedSchoolStage = stage;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void reset() {
    _selectedSchoolStage = null;
    _currentStep = 0;
    notifyListeners();
  }
}

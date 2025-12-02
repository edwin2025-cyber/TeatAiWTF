/// User model for WeTheFuture
class User {
  final String id;
  final String name;
  final int age;
  final String email;
  final SchoolStage schoolStage;
  final String themePreference;
  final UserLocation? location;
  final int xp;
  final int streakDays;
  final bool onboardingCompleted;
  final List<String> completedMissions;
  final List<String> completedLessons;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.schoolStage,
    this.themePreference = 'system',
    this.location,
    this.xp = 0,
    this.streakDays = 0,
    this.onboardingCompleted = false,
    this.completedMissions = const [],
    this.completedLessons = const [],
  });

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? email,
    SchoolStage? schoolStage,
    String? themePreference,
    UserLocation? location,
    int? xp,
    int? streakDays,
    bool? onboardingCompleted,
    List<String>? completedMissions,
    List<String>? completedLessons,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      schoolStage: schoolStage ?? this.schoolStage,
      themePreference: themePreference ?? this.themePreference,
      location: location ?? this.location,
      xp: xp ?? this.xp,
      streakDays: streakDays ?? this.streakDays,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      completedMissions: completedMissions ?? this.completedMissions,
      completedLessons: completedLessons ?? this.completedLessons,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'schoolStage': schoolStage.name,
      'themePreference': themePreference,
      'location': location?.toJson(),
      'xp': xp,
      'streakDays': streakDays,
      'onboardingCompleted': onboardingCompleted,
      'completedMissions': completedMissions,
      'completedLessons': completedLessons,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
      schoolStage: SchoolStage.values.firstWhere(
        (e) => e.name == json['schoolStage'],
        orElse: () => SchoolStage.none,
      ),
      themePreference: json['themePreference'] as String? ?? 'system',
      location: json['location'] != null
          ? UserLocation.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      xp: json['xp'] as int? ?? 0,
      streakDays: json['streakDays'] as int? ?? 0,
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      completedMissions: (json['completedMissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      completedLessons: (json['completedLessons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  /// Get civic level based on XP
  String get civicLevel {
    if (xp < 50) return 'Curious Citizen';
    if (xp < 150) return 'Informed Voter';
    if (xp < 300) return 'Engaged Activist';
    if (xp < 500) return 'Community Leader';
    return 'Civic Champion';
  }

  int get currentLevel {
    if (xp < 50) return 1;
    if (xp < 150) return 2;
    if (xp < 300) return 3;
    if (xp < 500) return 4;
    return 5;
  }

  int get xpForNextLevel {
    if (xp < 50) return 50;
    if (xp < 150) return 150;
    if (xp < 300) return 300;
    if (xp < 500) return 500;
    return 1000;
  }

  double get levelProgress {
    int previousLevelXp = 0;
    int nextLevelXp = 50;
    
    if (xp >= 50) {
      previousLevelXp = 50;
      nextLevelXp = 150;
    }
    if (xp >= 150) {
      previousLevelXp = 150;
      nextLevelXp = 300;
    }
    if (xp >= 300) {
      previousLevelXp = 300;
      nextLevelXp = 500;
    }
    if (xp >= 500) {
      previousLevelXp = 500;
      nextLevelXp = 1000;
    }
    
    return (xp - previousLevelXp) / (nextLevelXp - previousLevelXp);
  }
}

enum SchoolStage {
  middle,
  high,
  college,
  none,
}

extension SchoolStageExtension on SchoolStage {
  String get displayName {
    switch (this) {
      case SchoolStage.middle:
        return 'Middle school';
      case SchoolStage.high:
        return 'High school';
      case SchoolStage.college:
        return 'College or university';
      case SchoolStage.none:
        return "I'm not in school";
    }
  }

  String get subtitle {
    switch (this) {
      case SchoolStage.middle:
        return 'Grades 6–8 (or similar)';
      case SchoolStage.high:
        return 'Freshman to senior';
      case SchoolStage.college:
        return 'Undergrad or beyond';
      case SchoolStage.none:
        return 'Taking another path';
    }
  }
}

class UserLocation {
  final String statePostal;
  final String? county;
  final String? city;

  UserLocation({
    required this.statePostal,
    this.county,
    this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'statePostal': statePostal,
      'county': county,
      'city': city,
    };
  }

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      statePostal: json['statePostal'] as String,
      county: json['county'] as String?,
      city: json['city'] as String?,
    );
  }
}

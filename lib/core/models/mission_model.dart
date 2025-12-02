/// Mission model for WeTheFuture
class Mission {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final MissionCategory category;
  final List<String>? stateFilter;
  final bool requiresLocation;
  final String? iconName;

  Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.category,
    this.stateFilter,
    this.requiresLocation = false,
    this.iconName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'xpReward': xpReward,
      'category': category.name,
      'stateFilter': stateFilter,
      'requiresLocation': requiresLocation,
      'iconName': iconName,
    };
  }

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      xpReward: json['xpReward'] as int,
      category: MissionCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => MissionCategory.learn,
      ),
      stateFilter: (json['stateFilter'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requiresLocation: json['requiresLocation'] as bool? ?? false,
      iconName: json['iconName'] as String?,
    );
  }
}

enum MissionCategory {
  learn,
  engage,
  act,
}

extension MissionCategoryExtension on MissionCategory {
  String get displayName {
    switch (this) {
      case MissionCategory.learn:
        return 'Learn';
      case MissionCategory.engage:
        return 'Engage';
      case MissionCategory.act:
        return 'Act';
    }
  }

  String get description {
    switch (this) {
      case MissionCategory.learn:
        return 'Build your civic knowledge';
      case MissionCategory.engage:
        return 'Connect with your community';
      case MissionCategory.act:
        return 'Make a difference';
    }
  }
}

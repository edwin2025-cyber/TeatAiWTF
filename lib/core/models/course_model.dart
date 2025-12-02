/// Course and Lesson models for WeTheFuture
class Course {
  final String id;
  final String title;
  final String description;
  final String level;
  final String category;
  final String iconName;
  final List<Lesson> lessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.category,
    required this.iconName,
    required this.lessons,
  });

  int get totalLessons => lessons.length;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'level': level,
      'category': category,
      'iconName': iconName,
      'lessons': lessons.map((l) => l.toJson()).toList(),
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      category: json['category'] as String,
      iconName: json['iconName'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((l) => Lesson.fromJson(l as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final int estimatedMinutes;
  final List<ContentBlock> contentBlocks;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.estimatedMinutes,
    required this.contentBlocks,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'estimatedMinutes': estimatedMinutes,
      'contentBlocks': contentBlocks.map((c) => c.toJson()).toList(),
    };
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedMinutes: json['estimatedMinutes'] as int,
      contentBlocks: (json['contentBlocks'] as List<dynamic>)
          .map((c) => ContentBlock.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}

abstract class ContentBlock {
  final String type;

  ContentBlock({required this.type});

  Map<String, dynamic> toJson();

  factory ContentBlock.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'text':
        return TextBlock.fromJson(json);
      case 'image':
        return ImageBlock.fromJson(json);
      case 'quiz':
        return QuizBlock.fromJson(json);
      default:
        throw Exception('Unknown content block type');
    }
  }
}

class TextBlock extends ContentBlock {
  final String body;

  TextBlock({required this.body}) : super(type: 'text');

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'body': body,
    };
  }

  factory TextBlock.fromJson(Map<String, dynamic> json) {
    return TextBlock(body: json['body'] as String);
  }
}

class ImageBlock extends ContentBlock {
  final String src;
  final String alt;

  ImageBlock({required this.src, required this.alt}) : super(type: 'image');

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'src': src,
      'alt': alt,
    };
  }

  factory ImageBlock.fromJson(Map<String, dynamic> json) {
    return ImageBlock(
      src: json['src'] as String,
      alt: json['alt'] as String,
    );
  }
}

class QuizBlock extends ContentBlock {
  final String quizId;

  QuizBlock({required this.quizId}) : super(type: 'quiz');

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'quizId': quizId,
    };
  }

  factory QuizBlock.fromJson(Map<String, dynamic> json) {
    return QuizBlock(quizId: json['quizId'] as String);
  }
}

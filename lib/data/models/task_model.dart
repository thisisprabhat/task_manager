import 'package:hive_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  bool isCompleted;
  Task({
    this.id,
    this.title,
    this.description,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  @override
  String toString() {
    return 'Task('
        'id: $id,'
        'title: $title,'
        'description: $description,'
        'isCompleted: $isCompleted'
        ')';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isCompleted.hashCode;
  }
}

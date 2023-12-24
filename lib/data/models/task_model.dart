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
  @HiveField(4)
  DateTime? createdOn;
  @HiveField(5)
  DateTime? updatedOn;
  Task({
    this.id,
    this.title,
    this.description,
    this.isCompleted = false,
    this.createdOn,
    this.updatedOn,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdOn,
    DateTime? updatedOn,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdOn': createdOn?.millisecondsSinceEpoch,
      'updatedOn': updatedOn?.millisecondsSinceEpoch,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      isCompleted: map['isCompleted'] as bool,
      createdOn: map['createdOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int)
          : null,
      updatedOn: map['updatedOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedOn'] as int)
          : null,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, isCompleted: $isCompleted, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode;
  }
}

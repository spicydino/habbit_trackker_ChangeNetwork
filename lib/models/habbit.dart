import 'package:flutter/material.dart';

class Habit {
  String id;
  String title;
  String subtitle;
  IconData icon;
  bool isCompleted;

  Habit({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isCompleted,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? subtitle,
    IconData? icon,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  void toggleCompletion() {
    isCompleted = !isCompleted;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'icon': icon.codePoint,
      'isCompleted': isCompleted,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      isCompleted: map['isCompleted'] as bool,
    );
  }

  @override
  String toString() {
    return 'Habit(id: $id, title: $title, subtitle: $subtitle, icon: $icon, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant Habit other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.subtitle == subtitle &&
      other.icon == icon &&
      other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      icon.hashCode ^
      isCompleted.hashCode ;
  }
  }

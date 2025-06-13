// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Habit {
  String id;
  String title;
  String subtitle;
  IconData icon;
  bool isCompleted;
  DateTime createdAt;
  Habit({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isCompleted,
    required this.createdAt,
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
      createdAt: createdAt ?? this.createdAt,
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
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      isCompleted: map['isCompleted'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Habit(id: $id, title: $title, subtitle: $subtitle, icon: $icon, isCompleted: $isCompleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Habit other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.subtitle == subtitle &&
      other.icon == icon &&
      other.isCompleted == isCompleted &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      icon.hashCode ^
      isCompleted.hashCode ^
      createdAt.hashCode;
  }
  }
 
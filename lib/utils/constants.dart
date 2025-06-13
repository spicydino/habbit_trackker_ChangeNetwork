import 'package:flutter/material.dart';

class AppConstants {
  
  static const String appTitle = 'Daily Habit Tracker';
  
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFF5856D6);
  static const Color successColor = Color(0xFF34C759);
  static const Color backgroundColor = Color(0xFFF2F2F7);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color dividerColor = Color(0xFFE5E5EA);
  static const Color progressBarColor = Color(0xFF000000);
  
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;
  

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: textSecondary,
  );
  
  static const List<Map<String, dynamic>> defaultHabits = [
    {
      'title': 'Hydration',
      'subtitle': 'Drink 2 liters of water',
      'icon': Icons.water_drop_outlined,
    },
    {
      'title': 'Fitness',
      'subtitle': 'Exercise for 30 minutes',
      'icon': Icons.fitness_center_outlined,
    },
    {
      'title': 'Reading',
      'subtitle': 'Read for 30 minutes',
      'icon': Icons.menu_book_outlined,
    },
    {
      'title': 'Mindfulness',
      'subtitle': 'Meditate for 10 minutes',
      'icon': Icons.self_improvement_outlined,
    },
    {
      'title': 'Sleep',
      'subtitle': 'Sleep for 8 hours',
      'icon': Icons.bedtime_outlined,
    },
  ];
  
  static const String emptyHabitsMessage = 'No habits yet. Add your first habit!';
  static const String allHabitsCompletedMessage = 'Great job! All habits completed!';
  static const String addHabitHint = 'Enter a new habit';
  static const String addHabitLabel = 'Add New Habit';
  static const String cancelButtonText = 'Cancel';
  static const String addButtonText = 'Add';
  static const String clearCompletedButtonText = 'Clear Completed';
  
  static const int maxHabitLength = 100;
  static const String habitTooLongError = 'Habit must be less than 100 characters';
  static const String emptyHabitError = 'Please enter a habit';
}
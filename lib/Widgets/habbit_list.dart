// widgets/habit_list_item.dart
import 'package:flutter/material.dart';
import '../models/habbit.dart';
import '../utils/constants.dart';

class HabitListItem extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;
  final bool showCheckbox;

  const HabitListItem({
    Key? key,
    required this.habit,
    required this.onToggle,
    this.showCheckbox = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: showCheckbox ? onToggle : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  habit.icon,
                  color: AppConstants.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              
              // Title and Subtitle 
              //sdsdssa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: habit.isCompleted 
                            ? AppConstants.textSecondary 
                            : AppConstants.textPrimary,
                        decoration: habit.isCompleted 
                            ? TextDecoration.lineThrough 
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      habit.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.textSecondary,
                        decoration: habit.isCompleted 
                            ? TextDecoration.lineThrough 
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Checkbox or completion indicator
              if (showCheckbox)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: habit.isCompleted 
                          ? AppConstants.primaryColor 
                          : AppConstants.textSecondary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    color: habit.isCompleted 
                        ? AppConstants.primaryColor 
                        : Colors.transparent,
                  ),
                  child: habit.isCompleted
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
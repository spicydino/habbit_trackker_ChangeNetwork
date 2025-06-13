import 'package:flutter/material.dart';
import 'package:habbit_tracker/utils/constants.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int completedHabits;
  final int totalHabits;

  const ProgressIndicatorWidget({
    super.key,
    required this.completedHabits,
    required this.totalHabits,
  });

  @override
  Widget build(BuildContext context){
    final progress = totalHabits > 0 ? completedHabits / totalHabits: 0.0;
    final percentage =(progress * 100).round();

    return Container(
      margin:const EdgeInsets.all(16.0),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$percentage% of Habits Completed',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppConstants.textPrimary,
            ),
          ),
          const SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppConstants.dividerColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppConstants.progressBarColor,
              ),
              minHeight: 8.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '$completedHabits out of $totalHabits Habits Completed',
            style: const TextStyle(
              fontSize: 14,
              color: AppConstants.textSecondary,
            ),
          ),
        ],
      ),
    );
  
  }
  
  

  }

import 'package:flutter/material.dart';
import 'package:habbit_tracker/models/habbit.dart';
import '../Widgets/progress_indicator_widget.dart';
import 'package:habbit_tracker/utils/constants.dart';
import '../Widgets/add_habbit.dart';
import '../Widgets/habbit_list.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});
  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  List<Habit> _habits = [];

  @override
  void initState() {
    super.initState();
    _initializeDefaultHabits();
  }

  void _initializeDefaultHabits() {
    _habits = AppConstants.defaultHabits
        .map((habitData) => Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString() +
          habitData['title'].hashCode.toString(),
      title: habitData['title'],
      subtitle: habitData['subtitle'],
      icon: habitData['icon'],
      isCompleted: false,
      createdAt: DateTime.now(),
    ))
        .toList();
  }

  void _toggleHabit(int index) {
    setState(() {
      _habits[index].toggleCompletion();
    });
  }

  void _addHabit(String title, String subtitle) {
    setState(() {
      _habits.add(Habit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        subtitle: subtitle,
        icon: Icons.flag_outlined,
        isCompleted: false,
        createdAt: DateTime.now(),
      ));
    });
  }

  void _clearCompletedHabits() {
    setState(() {
      _habits.removeWhere((habit) => habit.isCompleted);
    });
  }

  void _showAddHabitDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const AddHabitDialog(),
    );

    if (result != null && result.isNotEmpty) {
      final parts = result.split(' ');
      final title = parts.isNotEmpty ? parts[0] : '';
      final subtitle = parts.length > 1 ? parts.sublist(1).join(' ') : '';

      _addHabit(title, subtitle);
    }
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flag_outlined,
            size: 64,
            color: AppConstants.textSecondary,
          ),
          SizedBox(height: 16),
          Text(
            'No habits yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppConstants.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add your first habit to get started!',
            style: TextStyle(
              fontSize: 14,
              color: AppConstants.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedHabits = _habits.where((habit) => habit.isCompleted).length;
    final totalHabits = _habits.length;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Daily Habits',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textPrimary,
                      ),
                    ),
                  ),

                  // Progress indicator (only show if there are habits)
                  if (totalHabits > 0)
                    ProgressIndicatorWidget(
                      completedHabits: completedHabits,
                      totalHabits: totalHabits,
                    ),

                  // Habits list
                  Expanded(
                    child: _habits.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: _habits.length,
                      itemBuilder: (context, index) {
                        final habit = _habits[index];
                        return HabitListItem(
                          habit: habit,
                          onToggle: () => _toggleHabit(index),
                        );
                      },
                    ),
                  ),

                  // Add habit input
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _clearCompletedHabits,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Clear Completed',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _showAddHabitDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Add Habit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

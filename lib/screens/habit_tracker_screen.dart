import 'package:flutter/material.dart';
import 'package:habbit_tracker/models/habbit.dart';
import 'package:habbit_tracker/widgets/progress_indicator_widget.dart';
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
  int _selectedIndex = 1;

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

  void _addHabit(String title) {
    setState(() {
      _habits.add(Habit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        subtitle: 'Custom habit',
        icon: Icons.flag_outlined,
        isCompleted: false,
        createdAt: DateTime.now(),
      ));
    });
  }

  void _showAddHabitDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const AddHabitDialog(),
    );

    if (result != null && result.isNotEmpty) {
      _addHabit(result);
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textPrimary),
          onPressed: () {},
        ),
        title: const Text(
          'Daily Habits',
          style: TextStyle(
            fontSize: 18,
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
          // White container for content
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppConstants.backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'What',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppConstants.textSecondary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'habit do you want to build?',
                                    hintStyle: TextStyle(
                                      color: AppConstants.textSecondary,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      _addHabit(value);
                                    }
                                  },
                                ),
                              ),
                            ],
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

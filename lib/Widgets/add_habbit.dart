
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({Key? key}) : super(key: key);

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    _textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      title: const Text(
        AppConstants.addHabitLabel,
        style: AppConstants.subtitleStyle,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: AppConstants.addHabitHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonBorderRadius,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonBorderRadius,
                  ),
                  borderSide: const BorderSide(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.flag_outlined,
                  color: AppConstants.primaryColor,
                ),
                counterText: '${_textController.text.length}/${AppConstants.maxHabitLength}',
              ),
              maxLength: AppConstants.maxHabitLength,
              textCapitalization: TextCapitalization.sentences,
              validator: _validateHabit,
              onChanged: (value) {
                setState(() {}); 
              },
              onFieldSubmitted: (_) => _submitHabit(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _textController2,
              decoration: InputDecoration(
                hintText: "Enter a description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonBorderRadius,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonBorderRadius,
                  ),
                  borderSide: const BorderSide(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.description,
                  color: AppConstants.primaryColor,
                ),
                counterText: '${_textController2.text.length}/${AppConstants.maxHabitLength}',
              ),
              maxLength: AppConstants.maxHabitLength,
              textCapitalization: TextCapitalization.sentences,
              validator: _validateHabit,
              onChanged: (value) {
                setState(() {});
              },
              onFieldSubmitted: (_) => _submitHabit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text(
            AppConstants.cancelButtonText,
            style: TextStyle(color: AppConstants.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submitHabit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.buttonBorderRadius,
              ),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(AppConstants.addButtonText),
        ),
      ],
    );
  }

  String? _validateHabit(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.emptyHabitError;
    }
    if (value.trim().length > AppConstants.maxHabitLength) {
      return AppConstants.habitTooLongError;
    }
    return null;
  }

  void _submitHabit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a brief loading state
      await Future.delayed(const Duration(milliseconds: 300));

      final habitTitle = _textController.text.trim();
      final habitDescription = _textController2.text.trim();

      final habit = "$habitTitle $habitDescription";
      
      if (mounted) {
        Navigator.of(context).pop(habit);
      }
    }
  }
}

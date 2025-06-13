// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/habit_tracker_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const DailyHabitTrackerApp());
}

class DailyHabitTrackerApp extends StatelessWidget {
  const DailyHabitTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppConstants.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppConstants.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary colors
        primaryColor: AppConstants.primaryColor,
        
        // Background colors
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        
        // Card theme
        cardTheme: CardTheme(
          color: AppConstants.cardColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          ),
        ),
        
        // AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        
        // FloatingActionButton theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        
        // Text theme
        textTheme: const TextTheme(
          displayLarge: AppConstants.titleStyle,
          titleLarge: AppConstants.subtitleStyle,
          bodyMedium: AppConstants.bodyStyle,
        ),
        
        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
            borderSide: BorderSide(
              color: AppConstants.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
            borderSide: BorderSide(
              color: AppConstants.primaryColor,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          fillColor: Colors.white,
          filled: true,
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: _createMaterialColor(AppConstants.primaryColor)).copyWith(background: AppConstants.backgroundColor),
      ),
      home: ,
    );
  }

  /// Helper method to create MaterialColor from a single Color
  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}


        
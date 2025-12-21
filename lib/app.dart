import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
ElevatedButtonThemeData _elevatedButtonThemeData()
{
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.themeColor,
        padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        fixedSize: Size.fromWidth(double.maxFinite)
    ),
  );
}
InputDecorationTheme _inputDecorationTheme()
{
  return InputDecorationTheme(
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300
      ),
      fillColor: Colors.white,
      filled: true,
      border: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      errorBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
  );
}
OutlineInputBorder _outlineInputBorder()
{
  return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8)
  );
}
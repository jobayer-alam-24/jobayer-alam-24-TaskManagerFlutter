import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager/controller_binder.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/canceled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/no_internet_screen.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/profile_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
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
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name : (context) => const SplashScreen(),
        AddNewTaskScreen.name : (context) => const AddNewTaskScreen(),
        CanceledTaskScreen.name : (context) => const CanceledTaskScreen(),
        CompletedTaskScreen.name : (context) => const CompletedTaskScreen(),
        ProgressTaskScreen.name : (context) => const ProgressTaskScreen(),
        SignUpScreen.name : (context) => const SignUpScreen(),
        SignInScreen.name : (context) => const SignInScreen(),
        MainBottomNavBarScreen.name : (context) => const MainBottomNavBarScreen(),
        NewTaskScreen.name : (context) => const NewTaskScreen(),
        NoInternetScreen.name : (context) => const NoInternetScreen(),
        PinVerificationScreen.name : (context) => const PinVerificationScreen(),
        ProfileScreen.name : (context) => const ProfileScreen(),
        ForgotPasswordEmailScreen.name : (context) => const ForgotPasswordEmailScreen(),
        ResetPasswordScreen.name : (context) => const ResetPasswordScreen()
      },
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      debugShowCheckedModeBanner: false,
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
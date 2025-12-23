import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/canceled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/tm_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  String? userName;
  String? userEmail;
  int _selectedIndex = 0;

  final GlobalKey<NewTaskScreenState> _newTaskKey = GlobalKey<NewTaskScreenState>();

  late final List<Widget> _widgets;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
    _widgets = [
      NewTaskScreen(key: _newTaskKey),
      const CompletedTaskScreen(),
      const CanceledTaskScreen(),
      const ProgressTaskScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: TMAppBar(userName: userName, userEmail: userEmail),
      body: _widgets[_selectedIndex],
        floatingActionButton: _selectedIndex == 0
            ? Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              final bool? shouldRefresh = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddNewTaskScreen()),
              );
              if (shouldRefresh == true) {
                _newTaskKey.currentState?.refreshTaskList();
              }
            },
            child: const Icon(Icons.add),
          ),
        )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColors.themeColor,
          color: AppColors.themeColor,
          height: 70,
          animationCurve: Curves.easeOut,
          animationDuration: const Duration(milliseconds: 400),
          index: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            Icon(Icons.new_label, color: Colors.white),
            Icon(Icons.check_box, color: Colors.white),
            Icon(Icons.close, color: Colors.white),
            Icon(Icons.punch_clock_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Future<void> loadUserInfo() async {
    userName = await AuthController.getFullName();
    userEmail = await AuthController.getEmail();
    setState(() {});
  }
}

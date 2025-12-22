import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/canceled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
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
  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }
  final List<Widget> _widgets = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(userName: userName, userEmail: userEmail),
      body: _widgets[_selectedIndex],
      bottomNavigationBar: NavigationBar(
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index)
          {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: [
        const NavigationDestination(
            icon: Icon(Icons.new_label),
            label: "New"
        ),
        const NavigationDestination(
            icon: Icon(Icons.check_box),
            label: "Completed"
        ),
        const NavigationDestination(
            icon: Icon(Icons.close),
            label: "Cancelled"
        ),
        const NavigationDestination(
            icon: Icon(Icons.punch_clock_rounded),
            label: "Progress"
        ),
      ]),
    );
  }

  Future<void> loadUserInfo() async {
    userName = await AuthController.getFullName();
    userEmail = await AuthController.getEmail();
    setState(() {});
  }
}


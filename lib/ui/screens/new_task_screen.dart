import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _taskSummarySection(),
          Expanded(child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const TaskCard();
              },
            separatorBuilder: (context, index)
            {
              return const SizedBox(height: 8,);
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          onPressed: _onTapAddNewTaskButton,
          child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }
 Widget _taskSummarySection()
  {
    return const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TaskSummaryCard(
                count: 09,
                title: "New",
              ),
              TaskSummaryCard(
                count: 09,
                title: "Completed",
              ),
              TaskSummaryCard(
                count: 09,
                title: "Cancelled",
              ),
              TaskSummaryCard(
                count: 09,
                title: "Progress",
              ),
            ],
          ),
        )
    );
  }
}




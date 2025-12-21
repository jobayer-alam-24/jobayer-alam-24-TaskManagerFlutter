import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';

import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTasksInProgress = false;
  List<TaskModel> taskLists = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
        },
        child: Column(
          children: [
            _taskSummarySection(),
            Expanded(child: Visibility(
              visible: !_getNewTasksInProgress,
              replacement: const CenterCircularProgressIndicator(),
              child: ListView.separated(
                  itemCount: taskLists.length,
                  itemBuilder: (context, index) {
                    return TaskCard(taskModel: taskLists[index],);
                  },
                separatorBuilder: (context, index)
                {
                  return const SizedBox(height: 8,);
                },
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          onPressed: _onTapAddNewTaskButton,
          child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onTapAddNewTaskButton()
  async {
    final bool? shouldRefresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
    if(shouldRefresh == true)
      {
        _getNewTaskList();
      }
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
  Future<void> _getNewTaskList() async
  {
    taskLists.clear();
    _getNewTasksInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.newTaskLists);
    if(response.isSuccess)
      {
        final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
        taskLists = taskListModel.data ?? [];
      }
    else {
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
    _getNewTasksInProgress = false;
    setState(() {});
  }
}




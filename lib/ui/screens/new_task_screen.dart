import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/models/task_status_model.dart';
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
  bool _getTaskStatusCountInProgress = false;
  List<TaskModel> taskLists = [];
  List<Task> taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getTaskStatusCountList();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await _getNewTaskList();
          await _getTaskStatusCountList();
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
                    return TaskCard(taskModel: taskLists[index], onRefreshList: () => _getNewTaskList(),);
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
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: !_getTaskStatusCountInProgress,
          replacement: CenterCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getListOfTaskSummaryCard(),
            ),
          ),
        )
    );
  }
  List<TaskSummaryCard> _getListOfTaskSummaryCard()
  {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for(Task t in taskStatusCountList)
      {
        taskSummaryCardList.add(TaskSummaryCard(title: t.sId!, count: t.sum!));
      }
    return taskSummaryCardList;
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
  Future<void> _getTaskStatusCountList() async
  {
    taskStatusCountList.clear();
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskStatusCountList);
    if(response.isSuccess)
    {
      final TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      taskStatusCountList = taskStatusCountModel.taskCountList ?? [];
    }
    else {
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }
}




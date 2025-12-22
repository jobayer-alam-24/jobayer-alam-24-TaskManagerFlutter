import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressedTaskListInProgress = false;
  List<TaskModel> taskLists = [];
  @override
  void initState() {
    _getProgressedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getProgressedTaskListInProgress,
      replacement: const CenterCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          _getProgressedTaskList();
        },
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 16),
          itemCount: taskLists.length,
          itemBuilder: (context, index) {
            return TaskCard(taskModel: taskLists[index], onRefreshList: _getProgressedTaskList,);
          },
          separatorBuilder: (context, index)
          {
            return const SizedBox(height: 8,);
          },
        ),
      ),
    );
  }

  Future<void> _getProgressedTaskList() async
  {
    taskLists.clear();
    _getProgressedTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.progressTaskLists);
    if(response.isSuccess)
    {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      taskLists = taskListModel.data ?? [];
    }
    else {
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
    _getProgressedTaskListInProgress = false;
    setState(() {});
  }
}

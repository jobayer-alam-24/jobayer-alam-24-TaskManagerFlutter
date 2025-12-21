import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskListInProgress = false;
  List<TaskModel> taskLists = [];

  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskListInProgress,
      replacement: const CenterCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 16),
          itemCount: taskLists.length,
          itemBuilder: (context, index) {
            return TaskCard(taskModel: taskLists[index],);
          },
          separatorBuilder: (context, index)
          {
            return const SizedBox(height: 8,);
          },
        ),
      ),
    );
  }
  Future<void> _getCompletedTaskList() async
  {
    taskLists.clear();
    _getCompletedTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.completedTaskLists);
    if(response.isSuccess)
    {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      taskLists = taskListModel.data ?? [];
    }
    else {
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
    _getCompletedTaskListInProgress = false;
    setState(() {});
  }
}

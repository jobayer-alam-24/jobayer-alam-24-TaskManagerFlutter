import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  List<TaskModel> taskLists = [];

  @override
  void initState() {
    _getCancelledTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCancelledTaskListInProgress,
      replacement: const CenterCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCancelledTaskList();
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

  Future<void> _getCancelledTaskList() async
  {
    taskLists.clear();
    _getCancelledTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.canceledTaskLists);
    if(response.isSuccess)
    {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      taskLists = taskListModel.data ?? [];
    }
    else {
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/models/task_status_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';

import '../controllers/new_task_list_controller.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';
import 'no_internet_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static const String name = '/NewTaskScreen';
  @override
  NewTaskScreenState createState() => NewTaskScreenState();
}

class NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountInProgress = false;
  List<Task> taskStatusCountList = [];
  final NewTaskListController _newTaskListController = Get.find<NewTaskListController>();
  @override
  void initState() {
    super.initState();
    _getTaskStatusCountList();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _getNewTaskList();
        await _getTaskStatusCountList();
      },
      child: Column(
        children: [
          _taskSummarySection(),
          Expanded(
            child: GetBuilder<NewTaskListController>(
              builder: (controller)
              {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: controller.taskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: controller.taskList[index],
                        onRefreshList: () => _getNewTaskList(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> refreshTaskList() async {
    await _getNewTaskList();
  }

  Widget _taskSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: !_getTaskStatusCountInProgress,
        replacement: const CenterCircularProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _getListOfTaskSummaryCard(),
          ),
        ),
      ),
    );
  }

  List<TaskSummaryCard> _getListOfTaskSummaryCard() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (Task t in taskStatusCountList) {
      taskSummaryCardList.add(TaskSummaryCard(title: t.sId!, count: t.sum!));
    }
    return taskSummaryCardList;
  }

  Future<void> _getNewTaskList() async {
    final bool result = await _newTaskListController.getNewTaskList();
    if (!result) {
      ShowSnackBarMessege(context, "Something went Wrong!", true);
    }
  }

  Future<void> _getTaskStatusCountList() async {
    taskStatusCountList.clear();
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskStatusCountList);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      taskStatusCountList = taskStatusCountModel.taskCountList ?? [];
    } else {
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }


}

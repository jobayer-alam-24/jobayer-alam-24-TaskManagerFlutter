import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/task_card.dart';
import 'no_internet_screen.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});
  static const String name = '/ProgressTaskScreen';
  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _controller = Get.find<ProgressTaskController>();
  @override
  void initState() {
    _getProgressedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(builder: (controller){
      return Visibility(
        visible: !controller.inProgress,
        replacement: const CenterCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: () async {
            await _getProgressedTaskList();
          },
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 16),
            itemCount: _controller.taskList.length,
            itemBuilder: (context, index) {
              return TaskCard(taskModel: controller.taskList[index], onRefreshList: _getProgressedTaskList,);
            },
            separatorBuilder: (context, index)
            {
              return const SizedBox(height: 8,);
            },
          ),
        ),
      );
    });
  }

  Future<void> _getProgressedTaskList() async
  {
    final result = await _controller.getProgressedTaskList();
    if(!result)
    {
      ShowSnackBarMessege(context, "Something went wrong!", true);
    }
  }
}

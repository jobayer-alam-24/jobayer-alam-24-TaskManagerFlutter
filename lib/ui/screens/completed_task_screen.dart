import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/task_card.dart';
import 'no_internet_screen.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static const String name = '/CompletedTaskScreeen';
  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _controller = Get.find<CompletedTaskController>();

  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedTaskController>(
        builder: (controller)
            {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const CenterCircularProgressIndicator(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _getCompletedTaskList();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: controller.taskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(taskModel: controller.taskList[index], onRefreshList: _getCompletedTaskList,);
                    },
                    separatorBuilder: (context, index)
                    {
                      return const SizedBox(height: 8,);
                    },
                  ),
                ),
              );
            }
    );
  }
  Future<void> _getCompletedTaskList() async
  {
    final result = await _controller.getCompletedTaskList();
    if(!result)
    {
      ShowSnackBarMessege(context, "Something went wrong!", true);
    }
  }
}

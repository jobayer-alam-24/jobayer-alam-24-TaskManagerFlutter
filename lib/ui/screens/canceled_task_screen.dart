import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/task_card.dart';
class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});
  static const String name = '/CancelledTaskScreen';
  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  final CancelledTaskController _controller = Get.find<CancelledTaskController>();
  @override
  void initState() {
    _getCancelledTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelledTaskController>
      (
        builder: (controller) {
          return  Visibility(
            visible: !controller.inProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: RefreshIndicator(
              onRefresh: () async{
                await _getCancelledTaskList();
              },
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: controller.taskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(taskModel: controller.taskList[index], onRefreshList: _getCancelledTaskList,);
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

  Future<void> _getCancelledTaskList() async
  {
    final bool result = await _controller.getCancelledTaskList();
    if(!result)
      ShowSnackBarMessege(context, "Something went wrong!", true);
    }
  }

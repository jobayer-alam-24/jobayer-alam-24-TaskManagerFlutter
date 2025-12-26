import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_status_count_model.dart';
import '../../data/models/task_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class GetTaskStatusCountListController extends GetxController {
  bool _inProgress = false;
  List<Task> _taskStatusCountList = [];
  bool get inProgress => _inProgress;
  List<Task> get taskStatusCountList => _taskStatusCountList;
  Future<bool> getTaskStatusCountList() async {
    bool isSuccess = false;
    taskStatusCountList.clear();
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskStatusCountList);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountModel.taskCountList ?? [];
      isSuccess = true;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
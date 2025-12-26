import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskController extends GetxController
{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessege;
  List<TaskModel> _taskLists = [];
  List<TaskModel> get taskList => _taskLists;
  String? get errorMessege => _errorMessege;

  Future<bool> getCompletedTaskList() async
  {
    bool isSucces = false;
    _taskLists.clear();
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.completedTaskLists);
    if(response.isSuccess)
    {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _taskLists = taskListModel.data ?? [];
      isSucces = true;
    }
    else {
      _errorMessege = response.errorMessege;
    }
    _inProgress = false;
    update();
    return isSucces;
  }
}
import 'package:task_manager/data/models/task_status_model.dart';

class TaskStatusCountModel {
  String? status;
  List<Task>? taskCountList;

  TaskStatusCountModel({this.status, this.taskCountList});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <Task>[];
      json['data'].forEach((v) {
        taskCountList!.add(Task.fromJson(v));
      });
    }
  }
}



class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String newTaskLists = '$_baseUrl/listTaskByStatus/New';
  static const String completedTaskLists = '$_baseUrl/listTaskByStatus/Completed';
  static const String canceledTaskLists = '$_baseUrl/listTaskByStatus/Canceled';
  static const String progressTaskLists = '$_baseUrl/listTaskByStatus/Progress';
  static const String taskStatusCountList = '$_baseUrl/taskStatusCount';
  static const String updateProfile = '$_baseUrl/profileUpdate';
  static String changeTaskStatus(String taskId, String taskStatus) => '$_baseUrl/updateTaskStatus/$taskId/$taskStatus';
  static String deleteTask(String taskId) => '$_baseUrl/deleteTask/$taskId';
}

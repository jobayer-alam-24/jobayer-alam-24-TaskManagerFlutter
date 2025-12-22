
class Task {
  String? sId;
  int? sum;

  Task({this.sId, this.sum});

  Task.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }
}
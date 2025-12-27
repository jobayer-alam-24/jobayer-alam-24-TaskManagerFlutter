import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel, required this.onRefreshList,
  });
  final TaskModel taskModel;

  final VoidCallback onRefreshList;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  bool _changeTaskStatus = false, _deleteTaskStatus = false;
  @override
  void initState() {
    _selectedStatus = widget.taskModel.status!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: getCardColor(widget.taskModel.status),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: getCardBorderColor(widget.taskModel.status), width: 1.5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.title ?? '', style: Theme
                .of(context)
                .textTheme
                .titleSmall,),
            Text(widget.taskModel.description ?? ''),
            Text("Date: ${widget.taskModel.createdDate}" ?? ''),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(status: widget.taskModel.status,),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: _onTapEditButton, icon: Icon(Icons.edit, color: Colors.blue,)),
                    IconButton(onPressed: _onTapDeleteButton,
                        icon: Icon(Icons.delete, color: Colors.red,)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTapEditButton() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Edit Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ["New", "Completed", "Canceled", "Progress"].map((e) {
            return ListTile(
              onTap: () {
                _changeStatus(e);
                Navigator.pop(context);
              },
              selected: _selectedStatus == e,
              trailing: _selectedStatus == e ? Icon(Icons.check) : null,
              title: Text(e),
            );
          }).toList(),
        ),
        actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Okay")),
        ],
      );
    });
  }

  Future<void> _onTapDeleteButton() async {
    _deleteTaskStatus = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel.sId!)
    );
    if(response.isSuccess)
    {
      widget.onRefreshList();
    }else {
      _deleteTaskStatus = false;
      setState(() {});
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
  }


  Future<void> _changeStatus(String newStatus) async
  {
    _changeTaskStatus = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changeTaskStatus(widget.taskModel.sId!, newStatus)
    );
    if(response.isSuccess)
      {
        widget.onRefreshList();
      }else {
      _changeTaskStatus = false;
      setState(() {});
      ShowSnackBarMessege(context, response.errorMessege, true);
    }

  }
  Color getCardColor(String? status) {
    switch (status) {
      case 'New':
        return Colors.blue.shade50;
      case 'Completed':
        return Colors.green.shade50;
      case 'Canceled':
        return Colors.red.shade50;
      case 'Progress':
        return Colors.orange.shade50;
      default:
        return Colors.white;
    }
  }

  Color getCardBorderColor(String? status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Canceled':
        return Colors.red;
      case 'Progress':
        return Colors.orange;
      default:
        return AppColors.themeColor;
    }
  }
}
class _buildTaskStatusChip extends StatelessWidget {
  const _buildTaskStatusChip({
    super.key, required this.status,
  });

  final String? status;

  @override
  Widget build(BuildContext context) {
    final color = getStatusColor(status);
    return Chip(label: Text(status ?? '', style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,

    ),), shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
        side: BorderSide(color: color)
    ),);
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Canceled':
        return Colors.red;
      case 'Progress':
        return Colors.orange;
      default:
        return AppColors.themeColor;
    }
  }

}

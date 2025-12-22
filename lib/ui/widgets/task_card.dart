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
  bool _changeStatusInProgress = false;
  bool _deleteTaskStaus = false;
  @override
  void initState() {
    _selectedStatus = widget.taskModel.status!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
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
                        onPressed: _onTapEditButton, icon: Icon(Icons.edit)),
                    IconButton(onPressed: _onTapDeleteButton,
                        icon: Icon(Icons.delete)),
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
    _deleteTaskStaus = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel.sId!)
    );
    if(response.isSuccess)
    {
      widget.onRefreshList();
    }else {
      _deleteTaskStaus = false;
      setState(() {});
      ShowSnackBarMessege(context, response.errorMessege, true);
    }
  }


  Future<void> _changeStatus(String newStatus) async
  {
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changeTaskStatus(widget.taskModel.sId!, newStatus)
    );
    if(response.isSuccess)
      {
        widget.onRefreshList();
      }else {
      _changeStatusInProgress = false;
      setState(() {});
      ShowSnackBarMessege(context, response.errorMessege, true);
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
    return Chip(label: Text(status ?? '', style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,

    ),), shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
      side: BorderSide(color: AppColors.themeColor)
    ),);
  }
}
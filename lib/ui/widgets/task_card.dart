import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel,
  });
  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
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
            Text(widget.taskModel.createdDate ?? ''),
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
          children: ["New", "Completed", "Cancelled", "Progress"].map((e) {
            return ListTile(
              onTap: (){},
              title: Text(e),
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(onPressed: (){}, child: Text("Okay")),
        ],
      );
    });
  }

  void _onTapDeleteButton() {

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
      fontWeight: FontWeight.bold
    ),), shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
      side: BorderSide(color: AppColors.themeColor)
    ),);
  }
}
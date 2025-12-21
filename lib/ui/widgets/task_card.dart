import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
  });

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
            Text("Title Of the Text", style: Theme
                .of(context)
                .textTheme
                .titleSmall,),
            Text("Description of the Task"),
            Text("22/04/2024"),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(label: const Text("New", style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold
    ),), shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
      side: BorderSide(color: AppColors.themeColor)
    ),);
  }
}
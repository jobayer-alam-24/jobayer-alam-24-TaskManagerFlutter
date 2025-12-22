
import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key, required this.title, required this.count,
  });
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    final color = getTaskSummaryColor(title);
    return Card(
      color: color.withOpacity(0.1),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 1.5),
      ),
      child: SizedBox(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$count", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                color: color
              ),),
              const SizedBox(height: 4,),
              Text(title, style: TextStyle(
                  color: color
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Color getTaskSummaryColor(String title) {
    switch (title) {
      case 'New':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Canceled':
        return Colors.red;
      case 'Progress':
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }

}
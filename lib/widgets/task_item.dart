import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/add_task_dialog.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
      },
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            Provider.of<TaskProvider>(context, listen: false)
                .toggleTaskCompletion(task.id);
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AddTaskDialog(
                task: task,
              ),
            );
          },
        ),
      ),
    );
  }
}
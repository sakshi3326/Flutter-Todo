import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class AddTaskDialog extends StatelessWidget {
  final Task? task;

  const AddTaskDialog({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: task?.title ?? '');

    return AlertDialog(
      title: Text(task == null ? 'Add Task' : 'Edit Task'),
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(labelText: 'Task Title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (textController.text.isNotEmpty) {
              if (task == null) {
                Provider.of<TaskProvider>(context, listen: false)
                    .addTask(textController.text);
              } else {
                Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(task!.id, textController.text);
              }
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
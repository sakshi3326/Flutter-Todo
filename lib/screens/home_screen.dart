import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import '../widgets/add_task_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => const AddTaskDialog(),
              );
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (ctx, taskProvider, _) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (ctx, index) {
              final task = taskProvider.tasks[index];
              return TaskItem(task: task);
            },
          );
        },
      ),
    );
  }
}
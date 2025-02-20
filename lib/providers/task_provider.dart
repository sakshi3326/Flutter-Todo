import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  static const String _tasksKey = 'tasks';

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey) ?? [];
    _tasks = tasksJson.map((taskJson) => Task.fromMap(jsonDecode(taskJson))).toList();
    notifyListeners();
  }

  // Save tasks to SharedPreferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = _tasks.map((task) => jsonEncode(task.toMap())).toList();
    prefs.setStringList(_tasksKey, tasksJson);
  }

  Future<void> addTask(String title) async {
    _tasks.add(Task(
      id: DateTime.now().toString(),
      title: title,
    ));
    notifyListeners();
    await _saveTasks();
  }

  Future<void> updateTask(String id, String newTitle) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex].title = newTitle;
      notifyListeners();
      await _saveTasks();
    }
  }

  Future<void> toggleTaskCompletion(String id) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
      await _saveTasks();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    await _saveTasks();
  }
}
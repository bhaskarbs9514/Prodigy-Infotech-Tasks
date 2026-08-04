import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskService {
  List<Task> tasks = [];

  static const String storageKey = "tasks";

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? data = prefs.getStringList(storageKey);

    if (data != null) {
      tasks = data
          .map((e) => Task.fromJson(jsonDecode(e)))
          .toList();
    }
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = tasks
        .map((task) => jsonEncode(task.toJson()))
        .toList();

    await prefs.setStringList(storageKey, data);
  }

  // Add Task
  Future<void> addTask(
    String title, {
    DateTime? dueDate,
  }) async {
    tasks.add(
      Task(
        title: title,
        dueDate: dueDate,
      ),
    );

    await saveTasks();
  }

  // Delete Task
  Future<void> deleteTask(int index) async {
    tasks.removeAt(index);
    await saveTasks();
  }

  // Edit Task
  Future<void> editTask(
    int index,
    String newTitle,
  ) async {
    tasks[index].title = newTitle;
    await saveTasks();
  }

  // Toggle Completed
  Future<void> toggleTask(int index) async {
    tasks[index].isCompleted =
        !tasks[index].isCompleted;

    await saveTasks();
  }

  // Toggle Important
  Future<void> toggleImportant(int index) async {
    tasks[index].isImportant =
        !tasks[index].isImportant;

    await saveTasks();
  }
}
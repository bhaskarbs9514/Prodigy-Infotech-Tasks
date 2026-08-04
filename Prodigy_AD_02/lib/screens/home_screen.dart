// NOTE:
// This file is a template/skeleton for the advanced HomeScreen.
// It assumes the matching Task, TaskService, TaskTile, and AddTaskDialog
// files discussed earlier are already in your project.

import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/task_service.dart';
import '../utils/app_colors.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskService taskService = TaskService();

  final TextEditingController controller = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  @override
  void initState() {
    super.initState();
    loadTasks();
    searchController.addListener(() {
      setState(() {
        searchText = searchController.text.toLowerCase();
      });
    });
  }

  Future<void> loadTasks() async {
    await taskService.loadTasks();
    setState(() {});
  }

  List<Task> get filteredTasks => taskService.tasks
      .where((e) => e.title.toLowerCase().contains(searchText))
      .toList();

  int get completedTasks =>
      taskService.tasks.where((e) => e.isCompleted).length;

  Future<void> toggleImportant(int index) async {
    await taskService.toggleImportant(
      taskService.tasks.indexOf(filteredTasks[index]),
    );
    setState(() {});
  }

  void addTask() {
    controller.clear();

    showDialog(
      context: context,
      builder: (_) => AddTaskDialog(
        controller: controller,
        title: "Add Task",
        onSave: (date) async {
          if (controller.text.trim().isEmpty) return;

          await taskService.addTask(
            controller.text.trim(),
            dueDate: date,
          );

          setState(() {});
          if (mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void editTask(int index) {
    controller.text = filteredTasks[index].title;

    showDialog(
      context: context,
      builder: (_) => AddTaskDialog(
        controller: controller,
        title: "Edit Task",
        onSave: (_) async {
          await taskService.editTask(
            taskService.tasks.indexOf(filteredTasks[index]),
            controller.text.trim(),
          );

          setState(() {});
          if (mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void deleteTask(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await taskService.deleteTask(
                taskService.tasks.indexOf(filteredTasks[index]),
              );

              if (mounted) {
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text("To-Do List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search tasks...",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ${taskService.tasks.length}"),
                Text("Completed: $completedTasks"),
              ],
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: taskService.tasks.isEmpty
                ? 0
                : completedTasks / taskService.tasks.length,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredTasks.isEmpty
                ? const Center(child: Text("No Tasks Found"))
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return TaskTile(
                        task: filteredTasks[index],
                        onDelete: () => deleteTask(index),
                        onEdit: () => editTask(index),
                        onToggle: () async {
                          await taskService.toggleTask(
                            taskService.tasks.indexOf(filteredTasks[index]),
                          );
                          setState(() {});
                        },
                        onImportant: () => toggleImportant(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

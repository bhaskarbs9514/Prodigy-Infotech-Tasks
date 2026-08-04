import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import '../utils/app_colors.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback onImportant;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
    required this.onToggle,
    required this.onImportant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          activeColor: AppColors.primary,
          onChanged: (_) => onToggle(),
        ),

        title: Text(
          task.title,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        subtitle: task.dueDate != null
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "Due: ${DateFormat('dd MMM yyyy • hh:mm a').format(task.dueDate!)}",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            : null,

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: Icon(
                task.isImportant
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: onImportant,
            ),

            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.orange,
              ),
              onPressed: onEdit,
            ),

            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
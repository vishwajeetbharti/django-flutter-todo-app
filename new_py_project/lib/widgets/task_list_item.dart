import 'package:flutter/material.dart';
import 'package:new_py_project/models/task.dart';
import 'package:new_py_project/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (bool? checked) {
          Provider.of<TaskProvider>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}

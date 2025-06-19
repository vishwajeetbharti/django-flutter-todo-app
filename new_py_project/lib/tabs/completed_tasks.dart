import 'package:flutter/material.dart';
import 'package:new_py_project/providers/task_provider.dart';
import 'package:new_py_project/widgets/task_list.dart';
import 'package:provider/provider.dart';

class CompletedTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TaskProvider>(
        builder:
            (context, todos, child) => TaskList(tasks: todos.completedTasks),
      ),
    );
  }
}

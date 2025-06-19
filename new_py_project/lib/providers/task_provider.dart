import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_py_project/models/task.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    fetchTaks();
  }

  List<Task> _tasks = [];

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView(_tasks);
  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((todo) => !todo.completed));
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.completed));

  void addTodo(Task task) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/todo"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(task),
      );
      print('object --- ${response.body}');
      if (response.statusCode == 201) {
        task.id = json.decode(response.body)['id'];
        _tasks.add(task);
        notifyListeners();
      }
    } catch (e) {
      print(
        'object---$e-------${json.encode(task)}-----------------------${e.toString()}',
      );
    }
  }

  void toggleTodo(Task task) async {
    try {
      final taskIndex = _tasks.indexOf(task);
      _tasks[taskIndex].toggleCompleted();
      final response = await http.patch(
        Uri.parse("http://10.0.2.2:8000/todo/${task.id}"),

        headers: {"Content-Type": "application/json"},
        body: json.encode(task),
      );
      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        _tasks[taskIndex].toggleCompleted(); //revert back
      }
    } catch (e) {
      print('object---------------------------------${e.toString()}');
    }
  }

  void deleteTodo(Task task) async {
    try {
      final response = await http.delete(
        Uri.parse("http://10.0.2.2:8000/todo/${task.id}"),
      );
      if (response.statusCode == 204) {
        _tasks.remove(task);
        notifyListeners();
      }
    } catch (e) {
      print('object---------------------------------${e.toString()}');
    }
  }

  fetchTaks() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:8000/todo"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        _tasks = data.map<Task>((json) => Task.fromJason(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('object---------------------------------${e.toString()}');
    }
  }
}

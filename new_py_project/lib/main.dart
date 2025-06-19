import 'package:flutter/material.dart';
import 'package:new_py_project/providers/task_provider.dart';
import 'package:new_py_project/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todos',
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}

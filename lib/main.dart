import 'package:app_tarefas/screens/main_dashboard.dart';
import 'package:app_tarefas/screens/task_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_tarefas/screens/task_details_screen.dart';

void main() {
  runApp(TodoList());
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainDashboard(),
      // routes: {
      //   '/': (context) => const MainDashboard(),
      //   '/task_details': (context) =>
      //       TaskDetailsScreen(listName: ModalRoute.of(context)!.settings.arguments as String),
      // },
    );
  }
}

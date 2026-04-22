import 'package:app_tarefas/main.dart';
import 'package:app_tarefas/models/tarefa_model.dart';
import 'package:app_tarefas/models/todo_list_model.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TodoListModel todoList;

  const TaskDetailsScreen({super.key, required this.todoList});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController _taskController = TextEditingController();

  void _addNewTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        // CORREÇÃO 1: Removido o ; de dentro do add e a vírgula extra
        widget.todoList.tasks.add(TaskModel(title: _taskController.text));
      });
      _taskController.clear(); // Sempre limpe o campo após adicionar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.todoList.title), backgroundColor: Colors.amberAccent),
      // CORREÇÃO 2: Removido o ; solto e adicionado um widget básico para teste
      body: Center(child: Text("Tarefas: ${widget.todoList.tasks.length}")),
    );
  }
}

/* 

💡 Resumindo de forma simples
State = dados que mudam na tela
StatefulWidget = widget que pode mudar
setState() = avisa o Flutter pra redesenhar

*/

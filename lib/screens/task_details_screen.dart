import 'package:app_tarefas/main.dart';
import 'package:app_tarefas/models/tarefa_model.dart';
import 'package:app_tarefas/models/todo_list_model.dart';
import 'package:app_tarefas/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      // PROVIDER: Em vez de usar setState local, chama o Provider
      // Usar o 'read' porque é uma ação de clique de botão
      context.read<TodoProvider>().addTask(widget.todoList, _taskController.text);

      _taskController.clear();
      // O setState sumiu daqui também!
      // O notifyListeners() do Provider vai atualizar a tela sozinho.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.todoList.title), backgroundColor: Colors.amberAccent),
      // CORREÇÃO 2: Removido o ; solto e adicionado um widget básico para teste
      // Dentro do Widget build da TaskDetailsScreen
      body: Column(
        children: [
          // Parte de cima: Onde você digita e adiciona (ajuste conforme seu widget de input)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(hintText: "Nova tarefa..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addNewTask, // Aquela função que já criamos
                ),
              ],
            ),
          ),

          // Parte de baixo: A lista de Checklist
          Expanded(
            child:
                context
                    .watch<TodoProvider>()
                    .todoLists
                    .firstWhere((l) => l.title == widget.todoList.title)
                    .tasks
                    .isEmpty
                ? const Center(child: Text("Nenhuma tarefa adicionada."))
                : ListView.builder(
                    itemCount: widget.todoList.tasks.length,
                    itemBuilder: (context, index) {
                      final tarefa = widget.todoList.tasks[index];

                      return ListTile(
                        leading: Checkbox(
                          value: tarefa.isCompleted,
                          onChanged: (bool? value) {
                            // PROVIDER: Chama a função de marcar/desmarcar
                            context.read<TodoProvider>().toggleTask(tarefa);
                          },
                        ),
                        title: Text(
                          tarefa.title,
                          style: TextStyle(
                            decoration: tarefa.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Vamos criar essa função no Provider logo abaixo
                            context.read<TodoProvider>().removeTask(widget.todoList, index);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/* 

💡 Resumindo de forma simples
State = dados que mudam na tela
StatefulWidget = widget que pode mudars
setState() = avisa o Flutter pra redesenhar

*/

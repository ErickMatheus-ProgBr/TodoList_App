import 'package:app_tarefas/models/todo_list_model.dart';
import 'package:app_tarefas/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tarefas/theme/colors.dart';

/// StatefulWidget: Usamos aqui porque temos um 'TextEditingController'
/// que precisa ser criado e descartado pela própria tela.
class TaskDetailsScreen extends StatefulWidget {
  final TodoListModel todoList; // Recebe a lista que foi clicada na Dashboard

  const TaskDetailsScreen({super.key, required this.todoList});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  // Controlador para o campo de texto da nova tarefa
  final TextEditingController _taskController = TextEditingController();

  /// Função interna para adicionar tarefa
  void _addNewTask() {
    if (_taskController.text.isNotEmpty) {
      // context.read: Dá uma ordem ao Provider para adicionar a tarefa na lista atual.
      context.read<TodoProvider>().addTask(widget.todoList, _taskController.text);

      // Limpa o campo de texto após adicionar
      _taskController.clear();

      // O notifyListeners() do Provider fará a tela atualizar automaticamente!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Exibe o título da lista em letras maiúsculas
        title: Text(
          widget.todoList.title.toUpperCase(),
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey, // Cor da barra superior
      ),
      body: Column(
        children: [
          // CABEÇALHO: Campo de entrada e botão "+"
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
                  icon: const Icon(Icons.add, color: AppColors.grayAppBar),
                  onPressed: _addNewTask,
                ),
              ],
            ),
          ),

          // LISTA DE TAREFAS: Usa o 'watch' para monitorar mudanças no Provider
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
                        // CHECKBOX: Onde o usuário marca como concluído
                        leading: Checkbox(
                          value: tarefa.isCompleted,
                          onChanged: (bool? value) {
                            // Envia para o Provider a tarefa e a lista para reorganizar o topo
                            context.read<TodoProvider>().toggleTask(widget.todoList, tarefa);
                          },
                        ),
                        // TÍTULO DA TAREFA: Fica riscado se estiver concluída
                        title: Text(
                          tarefa.title,
                          style: TextStyle(
                            decoration: tarefa.isCompleted
                                ? TextDecoration
                                      .lineThrough // Efeito de risco
                                : null,
                          ),
                        ),
                        // BOTÃO DE EXCLUIR TAREFA
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: AppColors.delete),
                          onPressed: () {
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

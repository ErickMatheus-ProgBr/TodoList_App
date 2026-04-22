import 'package:app_tarefas/main.dart';
import 'package:app_tarefas/models/tarefa_model.dart';
import 'package:app_tarefas/models/todo_list_model.dart';
import 'package:app_tarefas/screens/task_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_tarefas/widgets/addListMain.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final TextEditingController _listNameController = TextEditingController();

  final List<TodoListModel> todoLists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Topo da Página inicial
      appBar: AppBar(
        leading: Icon(Icons.check_box_outlined, color: Colors.white, size: 33),
        backgroundColor: Colors.black,
        title: Text(
          "Minhas Listas",
          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 0,
      ),

      body: todoLists.isEmpty
          ? const Center(child: Text("Nenhuma lista encontrada. Clique em + para adicionar uma!"))
          : ListView.builder(
              itemCount: todoLists.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
                  child: ListTile(
                    leading: const Icon(Icons.wysiwyg, color: Colors.black),
                    title: Text(
                      todoLists[index].title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 121, 121, 121),
                      ),
                    ),
                    trailing: const Icon(Icons.double_arrow_sharp, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsScreen(todoList: todoLists[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddListDialog(
            context: context,
            controller: _listNameController,
            onCreate: () {
              if (_listNameController.text.isNotEmpty) {
                setState(() {
                  todoLists.add(TodoListModel(title: _listNameController.text, tasks: []));
                });
                _listNameController.clear();
                Navigator.pop(context);
              }
            },
          );
        },
        backgroundColor: Colors.blue,
        elevation: 10,
        child: const Icon(Icons.add_circle_sharp, size: 40, color: Colors.white),
      ),
    );
  }
}




// showDialog: É o comando que "pausa" a tela de fundo e coloca algo na frente.

// AlertDialog: É o componente padrão do Android/iOS para mensagens e perguntas.

// Navigator.pop(context): Essa é a forma de dizer ao Flutter: "Feche a última coisa que você abriu" (neste caso, o diálogo).

// _listNameController.clear(): É muito importante limpar o campo, senão, quando você for criar a segunda lista, o nome da primeira ainda estará escrito lá.
import 'package:app_tarefas/provider/todo_provider.dart';
import 'package:app_tarefas/screens/task_details_screen.dart';
import 'package:app_tarefas/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_tarefas/widgets/addListMain.dart';
import 'package:provider/provider.dart';
import 'package:app_tarefas/logExclusion/dialogueofexclusion.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  // O Controller para capturar o texto que o usuário digita na caixa de diálogo
  final TextEditingController _listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // [CONCEITO] WATCH: Esta linha faz com que a tela "vigie" o Provider.
    // Sempre que você chamar 'notifyListeners()' no Provider, o Flutter redesenha
    // este Widget build automaticamente para mostrar os novos dados.
    final todoProvider = context.watch<TodoProvider>();

    return Scaffold(
      // Topo da Página inicial
      appBar: AppBar(
        leading: Icon(Icons.check_box_outlined, color: Colors.white, size: 33),
        backgroundColor: Colors.black,
        title: Text(
          "Minhas Listas",
          style: TextStyle(fontSize: 25, color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 0,
      ),

      // [LÓGICA] Verificamos se a lista dentro do Provider está vazia.
      // Se estiver vazia, mostramos uma mensagem amigável ao usuário.
      body: todoProvider.todoLists.isEmpty
          ? const Center(child: Text("Nenhuma lista encontrada. Clique em + para adicionar uma!"))
          : Padding(
              padding: const EdgeInsets.only(top: 18),
              child: ListView.builder(
                // Usamos o comprimento (length) da lista que está guardada no Provider
                itemCount: todoProvider.todoLists.length,
                itemBuilder: (context, index) {
                  // Usamos o comprimento (length) da lista que está guardada no Provider
                  final listaAtual = todoProvider.todoLists[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 11),
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
                    child: ListTile(
                      leading: const Icon(Icons.wysiwyg, color: Colors.black),
                      title: Text(
                        listaAtual.title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      trailing: const Icon(Icons.double_arrow_sharp, size: 16),
                      onTap: () {
                        // Navegação para a tela de detalhes enviando a lista selecionada
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailsScreen(todoList: listaAtual),
                          ),
                        );
                      },
                      onLongPress: () => confirmExclusion(context, index),
                    ),
                  );
                },
              ),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Chamamos o widget customizado de diálogo que criamos anteriormente
          showAddListDialog(
            context: context,
            controller: _listNameController,
            onCreate: () {
              if (_listNameController.text.isNotEmpty) {
                // [CONCEITO] READ: Aqui usamos o read porque queremos apenas
                // disparar uma função (addList) e não "vigiar" mudanças neste momento.
                // Isso é mais performático dentro de funções de clique (onPressed).
                context.read<TodoProvider>().addList(_listNameController.text);
                // Limpamos o texto para a próxima vez que o usuário abrir o diálogo
                _listNameController.clear();
                // Fecha o diálogo após a criação
                Navigator.pop(context);
              }
            },
          );
        },

        backgroundColor: AppColors.btnAddList,
        elevation: 10,
        child: const Icon(Icons.add_circle_sharp, size: 40, color: AppColors.white),
      ),
    );
  }
}




// showDialog: É o comando que "pausa" a tela de fundo e coloca algo na frente.

// AlertDialog: É o componente padrão do Android/iOS para mensagens e perguntas.

// Navigator.pop(context): Essa é a forma de dizer ao Flutter: "Feche a última coisa que você abriu" (neste caso, o diálogo).

// _listNameController.clear(): É muito importante limpar o campo, senão, quando você for criar a segunda lista, o nome da primeira ainda estará escrito lá.
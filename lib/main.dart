import 'package:app_tarefas/provider/todo_provider.dart';
import 'package:app_tarefas/screens/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Ponto de Entrada: A função main é o que o Flutter executa primeiro.
void main() {
  // [PROVIDER] ChangeNotifierProvider: Aqui é onde a "mágica" começa.
  runApp(ChangeNotifierProvider(create: (context) => TodoProvider(), child: const TodoList()));
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    // [CONFIGURAÇÃO] MaterialApp: É o widget raiz que define o estilo do app (Material Design).
    return MaterialApp(
      // Remove a faixa vermelha de "Debug";
      debugShowCheckedModeBanner: false,
      // Define a MainDashboard como a primeira tela a ser aberta.
      home: MainDashboard(),
    );
  }
}

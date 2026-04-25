import 'package:app_tarefas/provider/todo_provider.dart';
import 'package:app_tarefas/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Esta função cria e exibe uma janela flutuante (Pop-up) para confirmar a exclusão.
void confirmExclusion(BuildContext context, int index) {
  // O showDialog é uma função nativa do Flutter que cria uma janela na tela.
  showDialog(
    context: context,
    // O AlertDialog é o widget que dá o formato padrão de alerta (título, texto e botões).
    builder: (context) => AlertDialog(
      title: const Text("Excluir essa Tarefa"), // Título principal da janela.
      actions: [
        // Botão de Cancelar: Apenas fecha a janela sem fazer nada
        TextButton(
          onPressed: () =>
              Navigator.pop(context), // O Navigator.pop fecha o que estiver por cima (o diálogo).
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            // context.read acessa o Provider para executar a função de remover a lista.
            // Passamos o 'index' para o Provider saber exatamente qual posição da lista apagar.
            context.read<TodoProvider>().removeList(index);
            // Após dar a ordem de excluir, fechamos o diálogo para o utilizador voltar à lista principal.
            Navigator.pop(context);
          },
          child: Text("Exluir", style: TextStyle(color: AppColors.delete)),
        ),
      ],
    ),
  );
}

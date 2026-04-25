import 'package:flutter/material.dart';

/// Esta função global exibe uma janela para o usuário digitar o nome de uma nova lista.
/// Ela é "global" para que você possa chamá-la de qualquer lugar do app.
void showAddListDialog({
  required BuildContext context, // Localização na árvore de widgets
  required TextEditingController controller, // Controlador que captura o texto digitado
  required VoidCallback onCreate, // A função (ação) que será executada ao clicar em 'Criar'
}) {
  // showDialog: Comando do Flutter que "trava" a tela e mostra a janela pop-up.
  showDialog(
    context: context,
    builder: (context) {
      // AlertDialog: Widget que define o visual padrão de alertas (título, corpo e botões).
      return AlertDialog(
        title: const Text("Criar nova Lista"), // Título da janela
        // Content: É o "corpo" da janela. Aqui colocamos um campo de texto.
        content: TextField(
          controller: controller, // Vincula o campo ao controlador para lermos o texto depois
          autofocus: true, // Abre o teclado automaticamente ao aparecer a janela
          decoration: const InputDecoration(
            hintText: "Ex: Mercado", // Texto de exemplo dentro do campo
            helperText: "Digite o nome da lista", // Dica que fica logo abaixo do campo
          ),
        ),

        // Actions: São os botões de ação no rodapé da janela.
        actions: [
          // Botão Cancelar: Apenas fecha o diálogo sem salvar.
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),

          // ElevatedButton: Botão com destaque visual para a ação principal.
          ElevatedButton(
            onPressed: onCreate, // Executa a função recebida por parâmetro (adicionar no Provider)
            child: const Text("Criar"),
          ),
        ],
      );
    },
  );
}

import 'package:flutter/material.dart';

// Criamos uma função global (fora de qualquer classe) para ser acessível
void showAddListDialog({
  required BuildContext context,
  required TextEditingController controller,
  required VoidCallback onCreate,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Criar nova Lista"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Ex: Mercado",
            helperText: "Digite o nome da lista",
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: onCreate, // Aqui chamamos a função que passarmos por parâmetro
            child: const Text("Criar"),
          ),
        ],
      );
    },
  );
}

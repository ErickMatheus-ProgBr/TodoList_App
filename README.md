# app_tarefas

Estruturas de pastas

lib/
├── main.dart
├── models/
│   ├── tarefa_model.dart       # Define o que é uma tarefa (titulo, concluída)
│   └── lista_model.dart        # Define o que é uma lista (nome, ícone, lista de tarefas)
├── providers/
│   └── gerenciador_provider.dart # A lógica global: criar listas, adicionar tarefas e filtros
├── screens/
│   ├── painel_principal.dart   # Protótipo 1: Onde aparecem as "Pastas" de listas
│   └── checklist_detalhes.dart  # Protótipo 3: Onde aparecem as tarefas com check e delete
├── widgets/
│   ├── item_lista_widget.dart  # O design de cada "pasta" da tela inicial
│   └── item_tarefa_widget.dart # O design da linha com checkbox e lixeira
└── core/                       # (Opcional) Para cores e estilos fixos do app
    └── app_cores.dart
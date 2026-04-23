# app_tarefas

## 📝 To-Do List App (TaskMaster)
Um aplicativo de gerenciamento de tarefas desenvolvido em Flutter que permite organizar seu dia a dia em listas temáticas com persistência local de dados.

## 🚀 Funcionalidades
__Criação de Listas:__ Organize suas tarefas por categorias (ex: Mercado, Trabalho, Estudos).

__Checklist Reativo:__ Marque e desmarque tarefas com atualização em tempo real na interface._

__Persistência Local:__ Seus dados não somem ao fechar o app! Tudo é salvo no dispositivo usando shared_preferences.

Exclusão de Itens: Remova tarefas individualmente para manter suas listas limpas.

🛠️ Tecnologias Utilizadas
Flutter & Dart: Framework e linguagem base.

Provider: Gerenciamento de estado global e lógica de negócio.

Shared Preferences: Persistência de dados local (armazenamento de Strings JSON).

JSON Serialization: Conversão de objetos Dart para facilitar o salvamento.

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

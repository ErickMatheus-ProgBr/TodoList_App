import 'tarefa_model.dart';

class TodoListModel {
  String title; // O nome da lista
  List<TaskModel> tasks; // A lista de objetos do tipo TaskModel que moram aqui dentro

  TodoListModel({required this.title, required this.tasks});

  // [MÉTODO] toJson: Transforma o seu objeto Dart em um Mapa (JSON).
  // Isso é necessário porque o celular não entende o que é um "TodoListModel",
  // mas ele entende o que é um texto formatado em JSON.
  Map<String, dynamic> toJson() => {
    // Aqui usamos o .map para entrar em cada tarefa e transformá-la em JSON também
    "title": title, "tasks": tasks.map((t) => t.toJson()).toList(),
  };

  // [MÉTODO] factory fromJson: O caminho de volta.
  // Pega os dados que estavam salvos no celular (em formato de mapa)
  // e reconstrói o objeto TodoListModel para o Flutter usar.
  factory TodoListModel.fromJson(Map<String, dynamic> json) => TodoListModel(
    title: json['title'],
    // Convertemos a lista genérica que vem do JSON de volta para uma List<TaskModel>
    tasks: (json['tasks'] as List).map((t) => TaskModel.fromJson(t)).toList(),
  );
}

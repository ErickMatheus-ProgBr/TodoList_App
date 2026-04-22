import 'tarefa_model.dart';

class TodoListModel {
  String title;
  List<TaskModel> tasks; // Aqui sim usamos a lista

  TodoListModel({required this.title, required this.tasks});
}

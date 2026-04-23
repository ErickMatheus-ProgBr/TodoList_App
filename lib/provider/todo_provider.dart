import 'package:flutter/material.dart';
import '../models/todo_list_model.dart';
import '../models/tarefa_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  // A lista agora mora aqui!
  final List<TodoListModel> _todoLists = [];

  List<TodoListModel> get todoLists => _todoLists;

  TodoProvider() {
    loadData();
  }

  // 2. Salva a lista inteira no celular
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(_todoLists.map((l) => l.toJson()).toList());
    await prefs.setString('user_todo_data', encodedData);
  }

  // 3. Lê os dados salvos
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('user_todo_data');
    if (data != null) {
      Iterable decoded = jsonDecode(data);
      _todoLists.clear();
      _todoLists.addAll(decoded.map((item) => TodoListModel.fromJson(item)).toList());
      notifyListeners();
    }
  }

  // 4. Em toda função que muda dados, chame o saveData()
  void addList(String title) {
    _todoLists.add(TodoListModel(title: title, tasks: []));
    saveData(); // SALVA AQUI
    notifyListeners();
  }

  void addTask(TodoListModel list, String taskTitle) {
    list.tasks.add(TaskModel(title: taskTitle));
    saveData(); // SALVA AQUI
    notifyListeners();
  }

  // Função para criar uma nova pasta (lista)
  void addLis(String title) {
    _todoLists.add(TodoListModel(title: title, tasks: []));
    notifyListeners(); // Isso avisa as telas para se atualizarem!
  }

  // Dentro da classe TodoProvider
  void removeTask(TodoListModel list, int index) {
    list.tasks.removeAt(index);
    notifyListeners(); // Isso faz a lista sumir da tela na hora!
  }

  // Função para adicionar tarefa dentro de uma lista específica
  void addTas(TodoListModel list, String taskTitle) {
    list.tasks.add(TaskModel(title: taskTitle));
    notifyListeners();
  }

  // Função para marcar/desmarcar tarefa
  void toggleTask(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }
}

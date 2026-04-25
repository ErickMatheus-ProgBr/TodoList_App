import 'package:flutter/material.dart';
import '../models/todo_list_model.dart';
import '../models/tarefa_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoListModel> _todoLists = [];
  List<TodoListModel> get todoLists => _todoLists;

  TodoProvider() {
    loadData();
  }

  // --- LÓGICA DE PERSISTÊNCIA (SALVAR/LER) ---

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Usaremos apenas uma chave padronizada para não dar erro
    String encodedData = jsonEncode(_todoLists.map((l) => l.toJson()).toList());
    await prefs.setString('user_todo_data', encodedData);
  }

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

  // --- LÓGICA DE ORGANIZAÇÃO ---

  void _moveToTop(int index) {
    if (index > 0 && index < _todoLists.length) {
      final lista = _todoLists.removeAt(index);
      _todoLists.insert(0, lista);
    }
  }

  // --- AÇÕES DO APP ---

  // 1. Criar nova lista (Já entra no topo)
  void addList(String title) {
    _todoLists.insert(0, TodoListModel(title: title, tasks: []));
    _saveToPrefs();
    notifyListeners();
  }

  // 2. Adicionar tarefa e subir a lista para o topo
  void addTask(TodoListModel list, String taskTitle) {
    int index = _todoLists.indexOf(list);
    list.tasks.add(TaskModel(title: taskTitle));

    if (index != -1) _moveToTop(index); // Sobe a lista que recebeu a tarefa

    _saveToPrefs();
    notifyListeners();
  }

  // 3. Marcar/Desmarcar e subir para o topo
  void toggleTask(TodoListModel list, TaskModel task) {
    int index = _todoLists.indexOf(list);
    task.isCompleted = !task.isCompleted;

    if (index != -1) _moveToTop(index); // Sobe a lista que foi interagida

    _saveToPrefs();
    notifyListeners();
  }

  // 4. Remover tarefa
  void removeTask(TodoListModel list, int taskIndex) {
    list.tasks.removeAt(taskIndex);
    _saveToPrefs();
    notifyListeners();
  }

  // 5. Remover lista inteira
  void removeList(int index) {
    _todoLists.removeAt(index);
    _saveToPrefs();
    notifyListeners();
  }
}

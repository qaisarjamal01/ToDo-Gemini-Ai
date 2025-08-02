import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../models/category_model.dart';
import '../models/todo_model.dart';

/// A provider to manage the list of todos.
class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [
    // Initial dummy data for demonstration
    Todo(
      id: const Uuid().v4(),
      title: 'Finish Flutter Project',
      description: 'Complete the todo app with all features.',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      category: AppConstants.categoryWork,
      isCompleted: false,
    ),
    Todo(
      id: const Uuid().v4(),
      title: 'Buy Groceries',
      description: 'Milk, Bread, Eggs, and Cheese.',
      dueDate: DateTime.now().add(const Duration(hours: 3)),
      category: AppConstants.categoryPersonal,
      isCompleted: false,
    ),
    Todo(
      id: const Uuid().v4(),
      title: 'Read a book',
      description: 'Read a chapter of "The Lord of the Rings".',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      category: AppConstants.categoryHobby,
      isCompleted: true,
    ),
    Todo(
      id: const Uuid().v4(),
      title: 'Pay bills',
      description: 'Pay electricity and internet bills.',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      category: AppConstants.categoryFinance,
      isCompleted: false,
    ),
  ];

  final List<Category> _categories = [
    Category(name: AppConstants.categoryWork, color: Colors.blue),
    Category(name: AppConstants.categoryPersonal, color: Colors.green),
    Category(name: AppConstants.categoryHobby, color: Colors.orange),
    Category(name: AppConstants.categoryFinance, color: Colors.red),
    Category(name: AppConstants.categoryHealth, color: Colors.purple),
  ];

  List<Todo> get allTodos => _todos;
  List<Todo> get pendingTodos =>
      _todos.where((todo) => !todo.isCompleted).toList();
  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();
  List<Category> get categories => _categories;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      notifyListeners();
    }
  }
}
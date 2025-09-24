import 'package:todo_app/components/todo_filter.dart';
import 'package:todo_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

import '../services/service_locator.dart';

class TodoListNotifier extends ValueNotifier<List<Todo>> {
  TodoListNotifier() : super([]); //a lista inicia com esses valores aqui

  final _allTodosNotifier = ValueNotifier<List<Todo>>(
    [],
  ); //todos a lista sem filtro

  TodoFilter _currentFilter = TodoFilter.all;

  final _storageService = getIt<StorageService>();

  List<Todo> get _todos => _allTodosNotifier
      .value; //atalho pra n ficar escrevendo _allTodosNotifier.value toda hora

  void init() async {
    _allTodosNotifier.value = await _storageService.getTodos();
    _updateTodoList();
    _allTodosNotifier.addListener(() {
      _updateTodoList(); //o valor inicial sempre vão ser todas
      _saveTodoListToDB();
    });
  }

  void add(Todo todo) {
    _allTodosNotifier.value = [..._todos, todo];
  }

  void update(String id, String task) {
    _allTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(task: task),
    ];
  }

  void toggle(String id) {
    _allTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(completed: !todo.completed),
    ];
  }

  void remove(String id) {
    _allTodosNotifier.value = _todos.where((todo) => todo.id != id).toList();
  }

  void reorder(List<Todo> todos) {
    _allTodosNotifier.value = todos;
  }

  void changeFilter(TodoFilter filter) {
    _currentFilter = filter;
    _updateTodoList(); //chamando filtro
  }

  void _updateTodoList() {
    value =
        _mapFilterTodoList(); //definindo o filtro, depois de efetivamente filtrar
  }

  void _saveTodoListToDB() {
    _storageService.saveTodos(
      _todos.where((todo) => todo.task.isNotEmpty).toList(),
    );
  }

  List<Todo> _mapFilterTodoList() {
    switch (_currentFilter) {
      case TodoFilter.incomplete:
        return _todos.where((todo) => !todo.completed).toList();
      case TodoFilter.completed:
        return _todos.where((todo) => todo.completed).toList();
      case TodoFilter.all:
      return _todos.toList();
    }
  }
}

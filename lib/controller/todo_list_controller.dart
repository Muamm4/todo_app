import 'package:todo_app/components/todo_filter.dart';
import 'package:todo_app/components/todo_list_notifier.dart';
import 'package:flutter/cupertino.dart';

import '../models/todo.dart';

class TodoListController {
  final todoListNotifier = TodoListNotifier();
  final filterNotifier = ValueNotifier<TodoFilter>(
    TodoFilter.all,
  ); //valuenotifier dá pra add um listen

  void init() {
    todoListNotifier.init();
    filterNotifier.addListener(
      () => todoListNotifier.changeFilter(filterNotifier.value),
    );
  }

  void add(String task) {
    todoListNotifier.add(Todo.create(task));
  }

  void update(String id, String task) {
    todoListNotifier.update(id, task);
  }

  void toggle(String id) {
    todoListNotifier.toggle(id);
  }

  void remove(String id) {
    todoListNotifier.remove(id);
  }

  void changeFilter(TodoFilter filter) {
    filterNotifier.value = filter;
  }

  void reorder(oldIndex, newIndex) {
    if(oldIndex < newIndex){
      newIndex -= 1;
    } //quando o antigo é menor que o novo, pula dois na reordenação

    final todos = todoListNotifier.value;
    final todo = todos.removeAt(oldIndex); //remove da posição antiga
    todos.insert(newIndex, todo); //coloca na nova posição

    todoListNotifier.reorder(todos);
  }
}

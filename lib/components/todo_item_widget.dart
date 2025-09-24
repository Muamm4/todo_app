import 'dart:async';

import 'package:todo_app/controller/todo_list_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/service_locator.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late TextEditingController
  todoController; //late não vai ser nulo, valor será adicionado mais tarde

  final controller = getIt<TodoListController>();
  Timer? debouncer; //adiciona um delay antes de executar uma função, exemplo

  @override
  void initState() {
    todoController = TextEditingController(text: widget.todo.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        controller: todoController,
        autofocus: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration.collapsed(
          hintText: 'Escreva sua tarefa...',
        ),
        onChanged: onChanged,
      ),
      leading: Checkbox(value: widget.todo.completed, onChanged: onToggled, checkColor: Colors.white, activeColor: Colors.purple[600], hoverColor: Colors.purple[600], focusColor: Colors.purple[600],),
      trailing: IconButton(
        visualDensity: VisualDensity.compact,
        onPressed: onDeleted,
        icon: Icon(Icons.close_rounded),
      ),
    );
  }

  void onChanged(String task) {
    if (kDebugMode) {
      print(task);
    }
    debouncer
        ?.cancel(); //para que quando onchanged seja chamado novamente, não acumule
    debouncer = Timer(Duration(milliseconds: 500), () {
      controller.update(widget.todo.id, task);
    });
  }

  void onToggled(_) {
    if (kDebugMode) {
      print('toggled');
    }
    controller.toggle(widget.todo.id);
  }

  void onDeleted() {
    if (kDebugMode) {
      print('deleted');
    }
    controller.remove(widget.todo.id);
  }
}

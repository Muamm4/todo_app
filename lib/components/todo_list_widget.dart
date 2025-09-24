import 'package:todo_app/components/todo_filter.dart';
import 'package:todo_app/components/todo_item_widget.dart';
import 'package:todo_app/controller/todo_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import '../services/service_locator.dart';

//Arquivo que gera a lista

List<Todo> todoList = [
  Todo.create('Task 1'),
  Todo.create('Task 2'),
  Todo.create('Task 3'),
  Todo.create('Task 4'),
  Todo.create('Task 5'),
  Todo.create('Task 6'),
];

class TodoListWidget extends StatelessWidget {
  TodoListWidget({super.key});

  final controller = getIt<TodoListController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.todoListNotifier,
      builder: (context, todoList, child) {
        var isFilterAll = controller.todoListNotifier.value == TodoFilter.all;

        if (todoList.isEmpty && !isFilterAll) {
          return const Center(
            child: Padding(padding: EdgeInsets.all(16.0), child: Text('Vazio')),
          );
        }

        return ReorderableListView.builder(
          primary: false,
          shrinkWrap: true,
          buildDefaultDragHandles: isFilterAll, //só reordena em todos, em a fazer e concluídas não
          itemCount: todoList.length,
          onReorder: controller.reorder,
          itemBuilder: (context, index) {
            final todo = todoList[index];
            return TodoItemWidget(
              key: ValueKey(todo.id),
              todo: todo,
            ); //garantindo que cada tarefa seja única e que não seja atualizada com a mudança do index
          },
        );
      },
    );
  }
}

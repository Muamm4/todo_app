import 'package:todo_app/controller/todo_list_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/service_locator.dart';

class NewTodoWidget extends StatefulWidget {
  const NewTodoWidget({super.key});

  @override
  State<NewTodoWidget> createState() => _NewTodoWidgetState();
}

class _NewTodoWidgetState extends State<NewTodoWidget> {
  late TextEditingController todoController = TextEditingController();

  final controller = getIt<TodoListController>();
  final todoNode = FocusNode(); // tira o foco da digitação
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Form(
        key: formKey,
        child: TextFormField(
          focusNode: todoNode,
          controller: todoController,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration.collapsed(
            hintText: 'Escreva uma nova tarefa...',
          ),
          validator: (v) {
            if(v == null || v.isEmpty) {
              return 'Não pode ser vazio. :(';
            }
            return null;
          },
          onFieldSubmitted: (_) =>
              onSubmitted(), //já tem o controller, não precisa receber parâmetro aqui
        ),
      ),
      trailing: TextButton(onPressed: onSubmitted, child: Text('salvar')),
    );
  }

  void onSubmitted() {
    if (kDebugMode) {
      print('save');
    }
    //controller.remove(widget.todo.id);
    if (!formKey.currentState!.validate()) return; //validando que não estará vazio

    controller.add(todoController.text);

    formKey.currentState!.reset();//limpa o campo

    todoNode.unfocus();
  }
}

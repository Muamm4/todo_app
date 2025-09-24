import 'package:todo_app/components/menu.dart';
import 'package:todo_app/components/new_todo_widget.dart';
import 'package:todo_app/components/todo_filter.dart';
import 'package:todo_app/controller/todo_list_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/todo_list_widget.dart';
import '../services/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});

  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = getIt<TodoListController>();

  static const List<Tab> tabs = [
    Tab(
      text: 'Todas',
      icon: Icon(Icons.list_alt, size: 20),
    ),
    Tab(
      text: 'A Fazer',
      icon: Icon(Icons.radio_button_unchecked, size: 20),
    ),
    Tab(
      text: 'Concluídas',
      icon: Icon(Icons.check_circle_outline, size: 20),
    ),
  ];

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.black54,
        drawer: Menu(user: widget.user),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black54,
          foregroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              Text(
                'To Do App',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              color: Colors.black54,
              child: TabBar(
                tabs: tabs,
                labelColor: Colors.purple[600],
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: Colors.purple[600],
                indicatorWeight: 3,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                onTap: (index) {
                  controller.changeFilter(TodoFilter.values[index]);
                },
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54!,
                Colors.black54!,
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              ValueListenableBuilder(
                valueListenable: controller.filterNotifier,
                builder: (context, filter, child) {
                  if (filter == TodoFilter.completed) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const NewTodoWidget(),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TodoListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
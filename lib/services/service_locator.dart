import 'package:todo_app/controller/todo_list_controller.dart';
import 'package:todo_app/services/hive_storage.dart';
import 'package:todo_app/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<TodoListController>(() => TodoListController());
  getIt.registerLazySingleton<StorageService>(() => HiveStorage());
}

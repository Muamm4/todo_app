import '../models/todo.dart';

abstract class StorageService {
  Future<List<Todo>> getTodos(); //future garante que é assíncrono
  Future<void>saveTodos(List<Todo> todos);
}
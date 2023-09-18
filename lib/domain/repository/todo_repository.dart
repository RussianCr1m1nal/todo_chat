import 'package:injectable/injectable.dart';
import 'package:todo_chat/domain/entity/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> get todoListStream;
  Future<List<Todo>> fetchTodos();

  @disposeMethod
  void dispose();
}

import 'package:injectable/injectable.dart';
import 'package:todo_chat/data/datasource/remote_datasource.dart';
import 'package:todo_chat/domain/entity/todo.dart';
import 'package:todo_chat/domain/repository/todo_repository.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final RemoteDatasource _datasource;

  TodoRepositoryImpl(this._datasource);

  final BehaviorSubject<List<Todo>> _todoListSubject = BehaviorSubject<List<Todo>>.seeded([]);

  @override
  Stream<List<Todo>> get todoListStream => _todoListSubject.stream;

  @override
  Future<List<Todo>> fetchTodos() async {
    final todos = (await _datasource.getTodos()).map((e) => Todo.fromJson(e)).toList();
    _todoListSubject.add(todos);

    return todos;
  }

  @override
  void dispose() {
    _todoListSubject.close();
  }
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_chat/domain/entity/failure.dart';
import 'package:todo_chat/domain/entity/todo.dart';
import 'package:todo_chat/domain/repository/todo_repository.dart';

@injectable
class WatchTodosUseCase {
  final TodoRepository _repository;

  WatchTodosUseCase(this._repository);

  Either<Failure, Stream<List<Todo>>> call() {
    try {
      return Right(_repository.todoListStream);
    } catch (e, s) {
      return Left(
        Failure(
          message: e.toString(),
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }
}

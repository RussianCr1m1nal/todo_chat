import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_chat/domain/entity/failure.dart';
import 'package:todo_chat/domain/entity/todo.dart';
import 'package:todo_chat/domain/repository/todo_repository.dart';

@injectable
class FetchTodosUseCase {
  final TodoRepository _repository;

  FetchTodosUseCase(this._repository);

  Future<Either<Failure, List<Todo>>> call() async {
    try {
      return Right(await _repository.fetchTodos());
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

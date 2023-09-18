import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_chat/domain/entity/failure.dart';
import 'package:todo_chat/domain/entity/user.dart';
import 'package:todo_chat/domain/repository/user_repository.dart';

@injectable
class FetchUsersUseCase {
  final UserRepository _repository;

  FetchUsersUseCase(this._repository);

  Future<Either<Failure, List<User>>> call() async {
    try {
      return Right(await _repository.fetchUsers());
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

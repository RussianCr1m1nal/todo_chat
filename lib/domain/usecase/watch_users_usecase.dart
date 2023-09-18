import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_chat/domain/entity/failure.dart';
import 'package:todo_chat/domain/entity/user.dart';
import 'package:todo_chat/domain/repository/user_repository.dart';

@injectable
class WatchUsersUseCase {
  final UserRepository _repository;

  WatchUsersUseCase(this._repository);

  Either<Failure, Stream<List<User>>> call() {
    try {
      return Right(_repository.userListStream);
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

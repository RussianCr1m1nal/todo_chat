import 'package:injectable/injectable.dart';
import 'package:todo_chat/domain/entity/user.dart';

abstract class UserRepository {
  Stream<List<User>> get userListStream;
  Future<List<User>> fetchUsers();

  @disposeMethod
  void dispose();
}

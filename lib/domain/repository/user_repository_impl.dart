import 'package:injectable/injectable.dart';
import 'package:todo_chat/data/datasource/remote_datasource.dart';
import 'package:todo_chat/domain/entity/user.dart';
import 'package:todo_chat/domain/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final RemoteDatasource _datasource;

  UserRepositoryImpl(this._datasource);

  final BehaviorSubject<List<User>> _userListSubject = BehaviorSubject<List<User>>.seeded([]);

  @override
  Stream<List<User>> get userListStream => _userListSubject.stream;

  @override
  Future<List<User>> fetchUsers() async {
    final users = (await _datasource.getUsers()).map((e) => User.fromJson(e)).toList();
    _userListSubject.add(users);

    return users;
  }

  @override
  void dispose() {
    _userListSubject.close();
  }
}

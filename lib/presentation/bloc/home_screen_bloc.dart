import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_chat/domain/entity/todo.dart';
import 'package:todo_chat/domain/entity/user.dart';
import 'package:todo_chat/domain/usecase/fetch_todos_usecase.dart';
import 'package:todo_chat/domain/usecase/fetch_users_usecase.dart';
import 'package:todo_chat/domain/usecase/watch_todos_usecase.dart';
import 'package:todo_chat/domain/usecase/watch_users_usecase.dart';

@singleton
class HomeScreenBloc {
  final FetchUsersUseCase _fetchUsersUseCase;
  final FetchTodosUseCase _fetchTodosUseCase;
  final WatchUsersUseCase _watchUsersUseCase;
  final WatchTodosUseCase _watchTodosUseCase;

  final BehaviorSubject<int> _currentPageSubject = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<bool> _syncUsersStatusSubject = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _syncTodosStatusSubject = BehaviorSubject<bool>.seeded(false);

  final BehaviorSubject<List<User>> _userListSubject = BehaviorSubject<List<User>>.seeded([]);
  final BehaviorSubject<List<User>> _selectedUserListSubject = BehaviorSubject<List<User>>.seeded([]);
  final BehaviorSubject<List<Todo>> _todoListSubject = BehaviorSubject<List<Todo>>.seeded([]);

  StreamSubscription<List<User>>? _userListSubscription;
  StreamSubscription<List<Todo>>? _todoListSubscription;

  Stream<int> get currentPageStream => _currentPageSubject.stream;
  Stream<bool> get syncUserStatusStream => _syncUsersStatusSubject.stream;
  Stream<bool> get syncTodosStatusStream => _syncTodosStatusSubject.stream;

  Stream<List<User>> get userListStream => _userListSubject.stream;
  Stream<List<User>> get selectedUserListStream => _selectedUserListSubject.stream;
  Stream<List<Todo>> get todosListStream => _todoListSubject.stream;

  List<User> get selectedUsers => _selectedUserListSubject.value;

  HomeScreenBloc(
    this._fetchUsersUseCase,
    this._fetchTodosUseCase,
    this._watchUsersUseCase,
    this._watchTodosUseCase,
  ) {
    _setWatchers();
    _fetchUsers();
    _fetchTodos();
  }

  _setWatchers() {
    _watchUsersUseCase().fold((failure) {
      print(failure.message);
    }, (usersStream) {
      _userListSubscription?.cancel();
      _userListSubscription = usersStream.listen((users) {
        _userListSubject.add(users);
      });
    });

    _watchTodosUseCase().fold((failure) {
      print(failure.message);
    }, (todossStream) {
      _todoListSubscription?.cancel();
      _todoListSubscription = todossStream.listen((todos) {
        _todoListSubject.add(todos);
      });
    });
  }

  _fetchUsers() async {
    _syncUsersStatusSubject.add(true);
    (await _fetchUsersUseCase()).fold((failure) {
      print(failure.message);
    }, (r) {});
    _syncUsersStatusSubject.add(false);
  }

  _fetchTodos() async {
    _syncTodosStatusSubject.add(true);
    (await _fetchTodosUseCase()).fold((failure) {
      print(failure.message);
    }, (r) {});
    _syncTodosStatusSubject.add(false);
  }

  void toggleUserSelect(User user) {
    final newSelected = [..._selectedUserListSubject.value];

    if (isUserSelected(user)) {
      newSelected.remove(user);
    } else {
      newSelected.add(user);
    }

    _selectedUserListSubject.add(newSelected);
  }

  bool isUserSelected(User user) {
    return _selectedUserListSubject.value.contains(user);
  }

  void setCurrentPage(int newCurrentPage) {
    _currentPageSubject.add(newCurrentPage);
  }

  void dispose() {
    _userListSubscription?.cancel();
    _todoListSubscription?.cancel();

    _currentPageSubject.close();
    _userListSubject.close();
    _selectedUserListSubject.close();
    _todoListSubject.close();

    _syncUsersStatusSubject.close();
    _syncTodosStatusSubject.close();
  }
}

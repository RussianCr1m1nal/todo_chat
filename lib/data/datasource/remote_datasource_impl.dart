import 'package:injectable/injectable.dart';
import 'package:todo_chat/data/api/api_client.dart';
import 'package:todo_chat/data/datasource/remote_datasource.dart';

@Singleton(as: RemoteDatasource)
class RemoteDatasourceImpl implements RemoteDatasource {
  final ApiClient _client;

  RemoteDatasourceImpl(this._client);

  @override
  Future<List> getTodos() async {
    final response = await _client.get(path: 'todos');
    if (response.code == 200) {
      return response.data;
    } else {
      return [];
    }
  }

  @override
  Future<List> getUsers() async {
    final response = await _client.get(path: 'users');
    if (response.code == 200) {
      return response.data;
    } else {
      return [];
    }
  }
}

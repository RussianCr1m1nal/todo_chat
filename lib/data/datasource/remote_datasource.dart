abstract class RemoteDatasource {
  Future<List> getUsers();
  Future<List> getTodos();
}

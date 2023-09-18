import 'package:dio/dio.dart' as api;
import 'package:injectable/injectable.dart';
import 'package:todo_chat/data/api/model/api_response.dart';
import 'package:todo_chat/data/api/model/api_url.dart';

@Singleton()
class ApiClient {
  final api.Dio _client;
  final ApiUrl _url;

  ApiClient({
    required api.Dio client,
    required ApiUrl urlBuilder,
  })  : _client = client,
        _url = urlBuilder;

  Future<ApiResponse> get({
    required String path,
    Map<String, dynamic>? params,
  }) async {
    try {
      api.Response response = await _client.get(
        await _url.build(path: path),
      );

      return ApiResponse(response.data, response.statusCode);
    } on api.DioException catch (e) {
      print(e.response);
      rethrow;
    }
  }
}

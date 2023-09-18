import 'package:injectable/injectable.dart';

@Singleton()
class ApiUrl {
  Future<String> build({required String path}) async {
    return Uri(
      scheme: "https",
      host: "jsonplaceholder.typicode.com",
      path: "$path/",
    ).toString();
  }
}

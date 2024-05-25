import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadDatas() {
    return BaseNetwork.get("api");
  }
}

import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService({this.api});
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
  }
}

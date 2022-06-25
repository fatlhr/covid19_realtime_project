import 'dart:convert';

import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService({this.api});
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    debugPrint(
        'Request ${api.tokenUri()} failed.\nResponse: ${response.statusCode} ${response.reasonPhrase}.');
    throw response;
  }
}

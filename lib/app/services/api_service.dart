import 'dart:convert';

import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService({required this.api});
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      print('---token--- \n response: ${response.statusCode}');
      print('data:  ${data}');
      if (accessToken != null) {
        return accessToken;
      }
    }
    debugPrint(
        'Request ${api.tokenUri()} failed.\nResponse: ${response.statusCode} ${response.reasonPhrase}.');
    throw response;
  }

  Future<int> getEndPointData({
    required String accessToken,
    required Endpoint endpoint,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint]!;
        final int result = endpointData[responseJsonKey];
        String date = endpointData['date'];

        print('---endpoint--- \n response: ${response.statusCode}');
        print('endpointData:  ${endpointData}');
        print('result:  ${result}');
        print('date:  $date');

        debugPrint('$uri: $result');
        return result;
      }
    }
    debugPrint(
        'Request ${api.tokenUri()} failed.\nResponse: ${response.statusCode} ${response.reasonPhrase}.');
    throw response;
  }

  final Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
}

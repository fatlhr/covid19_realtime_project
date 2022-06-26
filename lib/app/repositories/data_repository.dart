import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:covid19_realtime_project/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService});
  final APIService apiService;
  late String _accessToken;
  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      if (_accessToken.isEmpty) {
        _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndPointData(
        endpoint: endpoint,
        accessToken: _accessToken,
      );
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndPointData(
          endpoint: endpoint,
          accessToken: _accessToken,
        );
      }
      rethrow;
    }
  }
}

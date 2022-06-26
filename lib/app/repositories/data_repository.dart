import 'package:covid19_realtime_project/app/repositories/endpoint_data.dart';
import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:covid19_realtime_project/app/services/api_service.dart';

import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService});
  final APIService apiService;
  String? _accessToken;
  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      _accessToken ??= await apiService.getAccessToken();
      return await apiService.getEndPointData(
        endpoint: endpoint,
        accessToken: _accessToken!,
      );
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndPointData(
          endpoint: endpoint,
          accessToken: _accessToken!,
        );
      }
      rethrow;
    }
  }

  Future<EndpointsData> getAllEndpointData() async {
    final values = await Future.wait([
      apiService.getEndPointData(
        accessToken: _accessToken!,
        endpoint: Endpoint.cases,
      ),
      apiService.getEndPointData(
        accessToken: _accessToken!,
        endpoint: Endpoint.casesConfirmed,
      ),
      apiService.getEndPointData(
        accessToken: _accessToken!,
        endpoint: Endpoint.casesSuspected,
      ),
      apiService.getEndPointData(
        accessToken: _accessToken!,
        endpoint: Endpoint.deaths,
      ),
      apiService.getEndPointData(
        accessToken: _accessToken!,
        endpoint: Endpoint.recovered,
      ),
    ]);
    return EndpointsData(values: {
      Endpoint.cases: values[0],
      Endpoint.casesConfirmed: values[1],
      Endpoint.casesSuspected: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}

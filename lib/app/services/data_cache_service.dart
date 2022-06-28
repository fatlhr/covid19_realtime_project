import 'package:covid19_realtime_project/app/repositories/endpoint_data.dart';
import 'package:covid19_realtime_project/app/services/endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';

class DataCacheService {
  DataCacheService({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  static String endpointValueKey(Endpoint endpoint) {
    return '$endpoint/value';
  }

  static String endpointDateKey(Endpoint endpoint) {
    return '$endpoint/date';
  }

  EndpointsData getData() {
    Map<Endpoint, Endpointdata> values = {};
    for (var endpoint in Endpoint.values) {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDateKey(endpoint));
      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = Endpointdata(value: value, date: date);
      }
    }
    return EndpointsData(values: values);
  }

  Future<void> setData(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(
        endpointValueKey(endpoint),
        endpointData.value,
      );
      await sharedPreferences.setString(
        endpointValueKey(endpoint),
        endpointData.date!.toIso8601String(),
      );
    });
  }
}

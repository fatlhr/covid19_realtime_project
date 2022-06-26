import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:covid19_realtime_project/app/services/endpoint_data.dart';

class EndpointsData {
  EndpointsData({required this.values});
  final Map<Endpoint, Endpointdata> values;

  Endpointdata get cases => values[Endpoint.cases]!;
  Endpointdata get casesonfirmed => values[Endpoint.casesConfirmed]!;
  Endpointdata get casesSuspected => values[Endpoint.casesSuspected]!;
  Endpointdata get deaths => values[Endpoint.deaths]!;
  Endpointdata get recovered => values[Endpoint.recovered]!;

  @override
  String toString() {
    return 'cases: $cases, casesonfirmed: $casesonfirmed, casesSuspected: $casesSuspected, deaths: $deaths, recovered: $recovered';
  }
}

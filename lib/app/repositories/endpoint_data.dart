import 'package:covid19_realtime_project/app/services/api.dart';

class EndpointsData {
  EndpointsData({required this.values});
  final Map<Endpoint, int> values;

  int get cases => values[Endpoint.cases]!;
  int get casesonfirmed => values[Endpoint.casesConfirmed]!;
  int get casesSuspected => values[Endpoint.casesSuspected]!;
  int get deaths => values[Endpoint.deaths]!;
  int get recovered => values[Endpoint.recovered]!;

  @override
  String toString() {
    return 'cases: $cases, casesonfirmed: $casesonfirmed, casesSuspected: $casesSuspected, deaths: $deaths, recovered: $recovered';
  }
}

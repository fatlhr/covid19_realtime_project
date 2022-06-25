import 'api_keys.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  final String apiKey;

  API({this.apiKey});

  factory API.sandbox() {
    return API(apiKey: APIKeys.ncovSandboxKey);
  }

  static const String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() {
    return Uri(
      scheme: 'https',
      host: host,
      path: 'token',
    );
  }

  Uri endpointUri(Endpoint endpoint) {
    return Uri(
      scheme: 'https',
      host: host,
      path: _paths[endpoint],
    );
  }

  static final Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };
}

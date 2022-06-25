import 'api_keys.dart';

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
}

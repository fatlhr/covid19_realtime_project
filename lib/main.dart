import 'package:covid19_realtime_project/app/ui/dashboard.dart';
import 'package:covid19_realtime_project/app/repositories/data_repository.dart';
import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:covid19_realtime_project/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/services/data_cache_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_US';
  await initializeDateFormatting();
  //Intl.getCurrentLocale();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
  //return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(api: API.sandbox()),
        dataCacheService: DataCacheService(
          sharedPreferences: sharedPreferences,
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cov19 Tracker',
        theme: ThemeData.dark().copyWith(
          cardColor: const Color(0xFF222222),
          scaffoldBackgroundColor: const Color(0xFF101010),
        ),
        home: const Dashboard(),
      ),
    );
  }
}

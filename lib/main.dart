import 'package:covid19_realtime_project/app/ui/dashboard.dart';
import 'package:covid19_realtime_project/app/repositories/data_repository.dart';
import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:covid19_realtime_project/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async{
  Intl.defaultLocale = 'en_US';
  await initializeDateFormatting();
  //Intl.getCurrentLocale();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(api: API.sandbox())),
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

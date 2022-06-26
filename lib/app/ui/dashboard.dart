import 'dart:io';

import 'package:covid19_realtime_project/app/repositories/data_repository.dart';
import 'package:covid19_realtime_project/app/repositories/endpoint_data.dart';
import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:covid19_realtime_project/app/ui/endpoint_card_widget.dart';
import 'package:covid19_realtime_project/app/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData? _endpointsData;
  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();

      setState(() {
        _endpointsData = endpointsData;
      });
    } on SocketException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData!.values[Endpoint.cases]!.date
            : null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cov19 Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          debugPrint('------refreshing------');
          return _updateData();
        },
        child: Center(
          child: _endpointsData == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    LastUpdatedTextStatus(
                        lastUpdated: formatter.lastUpdatedStatusText()),
                    for (var endpoint in Endpoint.values)
                      EndpointCard(
                        endpoint: endpoint,
                        value: _endpointsData != null
                            ? _endpointsData!.values[endpoint]!.value
                            : 0,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

import 'package:covid19_realtime_project/app/repositories/data_repository.dart';
import 'package:covid19_realtime_project/app/repositories/endpoint_data.dart';
import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:covid19_realtime_project/app/ui/endpoint_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cases = 0;
  int _cases2 = 0;
  int _data = 0;
  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(Endpoint.cases);
    final cases2 = await dataRepository.getAllEndpointData();
    final data = await dataRepository.getAllEndpointData();
    
    setState(() {
      _cases = cases;
      //_cases2 = cases2.cases ?? 0;
      _data = data.casesSuspected;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: ListView(
            children: <Widget>[
              EndpointCard(
                endpoint: Endpoint.cases,
                value: _cases,
              ),
              EndpointCard(
                endpoint: Endpoint.casesSuspected,
                value: _data,
              )
            ],
          ),
        ),
      ),
    );
  }
}

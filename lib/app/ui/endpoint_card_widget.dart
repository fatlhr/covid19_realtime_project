import 'package:covid19_realtime_project/app/repositories/endpoint_data.dart';
import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  const EndpointCard({
    Key? key,
    required this.value,
    required this.endpoint,
  }) : super(key: key);

  final Endpoint endpoint;
  final int value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 5,
      child: Card(
        margin: const EdgeInsets.all(16),
        color: Colors.deepPurple,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$endpoint',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                value.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

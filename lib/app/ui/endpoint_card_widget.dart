import 'package:covid19_realtime_project/app/repositories/endpoint_data.dart';
import 'package:covid19_realtime_project/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCardData {
  const EndpointCardData({
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;
}

class EndpointCard extends StatelessWidget {
  const EndpointCard({
    Key? key,
    required this.value,
    required this.endpoint,
  }) : super(key: key);

  final Endpoint endpoint;
  final int value;
  static Map<Endpoint, EndpointCardData> cardsData = {
    Endpoint.cases: const EndpointCardData(title: "Cases", color: Colors.red),
    Endpoint.casesConfirmed:
        const EndpointCardData(title: "Confirmed", color: Colors.amber),
    Endpoint.casesSuspected:
        const EndpointCardData(title: "Suspected", color: Colors.indigo),
    Endpoint.deaths:
        const EndpointCardData(title: "Deaths", color: Colors.grey),
    Endpoint.recovered:
        const EndpointCardData(title: "Recovered", color: Colors.green),
  };
  @override
  Widget build(BuildContext context) {
    final EndpointCardData endpoindCardsData = cardsData[endpoint]!;
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7,
      child: Card(
        margin: const EdgeInsets.all(16),
        color: endpoindCardsData.color,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                endpoindCardsData.title,
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

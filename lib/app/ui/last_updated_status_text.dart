import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormatter {
  const LastUpdatedDateFormatter({required this.lastUpdated});
  final DateTime? lastUpdated;
  String lastUpdatedStatusText() {
    if (lastUpdated != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdated!);
      return "Last updated: $formatted";
    }
    return "";
  }
}

class LastUpdatedTextStatus extends StatelessWidget {
  const LastUpdatedTextStatus({Key? key, required this.lastUpdated})
      : super(key: key);

  final String lastUpdated;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          lastUpdated,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}

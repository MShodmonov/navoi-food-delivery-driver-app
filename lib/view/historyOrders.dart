import 'package:flutter/material.dart';
import 'package:some_flutter/service/requests.dart';

class HistoryOrders extends StatefulWidget {
  const HistoryOrders({super.key, required this.token});

  final String token;

  @override
  _HIstoryOrders createState() => _HIstoryOrders();
}

class _HIstoryOrders extends State<HistoryOrders> {
  final ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('History Orders'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  getHistoryOrders() {
    apiClient
        .getActiveOrders(widget.token, 0, 10)
        .then((response) {

    })
        .catchError((error) {

    });
  }
}

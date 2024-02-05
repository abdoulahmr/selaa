import 'package:flutter/material.dart';
import 'package:selaa/backend-functions/load_data.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List<String> _orders = [];

  @override
  void initState() {
    super.initState();
    getAllOrderIDs().then((List<String> data) {
      setState(() {
        _orders = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print(_orders);
          },
          child: Text('Print Orders'),
        ),
      ),
    );
  }
}

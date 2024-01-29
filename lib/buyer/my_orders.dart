import 'package:flutter/material.dart';
import 'package:selaa/backend-functions/load_data.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    // Call the async function within initState
    _loadUserOrders();
  }

  // Define an async function to load user orders
  Future<void> _loadUserOrders() async {
    try {
      // Pass the context to loadUserOrders
      Map<String, List<Map<String, dynamic>>> groupedOrders = await loadUserOrders(context);
      setState(() {
        // Flatten the grouped orders into a single list
        _orders = groupedOrders.values.expand((orders) => orders).toList();
      });
    } catch (error) {
      // Handle errors if needed
      print('Error loading user orders: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Call the async function when the button is pressed
            await _loadUserOrders();
            for(var order in _orders) {
              print(order);
            }
          },
          child: Text('Print Orders'),
        ),
      ),
    );
  }
}

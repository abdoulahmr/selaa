import 'package:flutter/material.dart';
import 'package:selaa/backend-functions/load_data.dart';
import 'package:selaa/buyer/order_page.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadUserOrders(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> orders = snapshot.data!;
            return WillPopScope(
              onWillPop: () async => false,
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      title: Text(
                        'Order ${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Date: ${orders[index]['date']}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Status: ${orders[index]['status']}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(orderId: orders[index]['orderId']),
                        ));
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

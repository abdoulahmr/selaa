import 'package:flutter/material.dart';
import 'package:selaa/backend-functions/load_data.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List<Map<String, dynamic>> _orders = [];
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    loadUserOrders(context).then((List<Map<String, dynamic>> data){
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
      body: WillPopScope(
        onWillPop: () async { return false; },
        child: ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if(_isPressed==false){
                  _isPressed = true;
                  
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  title: Text(
                    'Order ${index + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Date: ${_orders[index]['date']}',
                        style: const TextStyle(
                          fontSize: 15
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Status: ${_orders[index]['status']}',
                        style: const TextStyle(
                          fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
